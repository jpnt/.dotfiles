local M = {}
local vim = vim
local uv  = vim.uv

-- Single-file minimal lazy loader ("plu")

local registry = {}
local data_path = vim.fn.stdpath("data") .. "/plu_plugins/"

local function extract_name(src)
  return src:match("[^/]+$")
end

local function compute_path(name)
  return data_path .. name
end

local function safe_notify(msg, lvl)
  vim.schedule(function()
    vim.notify(msg, lvl or vim.log.levels.INFO)
  end)
end

local function normalize(spec)
  if type(spec) == "string" then
    spec = { src = spec }
  end
  spec.lazy = spec.lazy ~= false
  spec.name = extract_name(spec.src)
  spec.path = compute_path(spec.name)
  if spec.version == true then
    spec.version = "*"
  end
  return spec
end

local function resolve_url(src)
  if src:match("^https?://") or src:match("^git@") or src:match("^git://") then
    return src
  end
  if src:match("^/") or src:match("^%.") or src:match("^~") then
    return src
  end
  return "https://github.com/" .. src .. ".git"
end

local function fs_exists(path)
  return uv.fs_stat(path) ~= nil
end

local function git_async(args, cwd, on_exit)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local error_output = ""

  local handle
  handle = uv.spawn("git", {
    args = args,
    cwd = cwd,
    stdio = { nil, stdout, stderr },
  }, function(code, signal)
    if stdout then pcall(stdout.close, stdout) end
    if stderr then pcall(stderr.close, stderr) end
    if handle then pcall(handle.close, handle) end

    if code ~= 0 and error_output ~= "" then
      safe_notify("[plu] git error: " .. table.concat(args, " ") .. " - " .. error_output, vim.log.levels.ERROR)
    end

    if on_exit then vim.schedule(function() on_exit(code == 0) end) end
  end)

  stdout:read_start(function() end)
  stderr:read_start(function(err, data)
    if data then error_output = error_output .. data end
  end)
end

local function rm_rf(path)
  local function _rm(p)
    local stat = uv.fs_stat(p)
    if not stat then return end

    if stat.type == "file" or stat.type == "link" then
      pcall(uv.fs_unlink, p)
      return
    end

    local req = uv.fs_scandir(p)
    if req then
      while true do
        local name = uv.fs_scandir_next(req)
        if not name then break end
        _rm(p .. "/" .. name)
      end
    end
    pcall(uv.fs_rmdir, p)
  end

  _rm(path)
end

local function install_plugin_async(spec, on_done)
  local url = resolve_url(spec.src)
  local temp_path = spec.path .. ".tmp." .. tostring(math.random(10000, 99999))

  vim.fn.mkdir(vim.fn.fnamemodify(spec.path, ":h"), "p")

  -- Clone without depth limit when we need specific versions
  local clone_args = {"clone", "--quiet", url, temp_path}

  git_async(clone_args, nil, function(ok)
    if not ok then
      safe_notify("[plu] failed to clone " .. spec.src, vim.log.levels.ERROR)
      rm_rf(temp_path)
      if on_done then on_done(false) end
      return
    end

    local function move_and_notify()
      -- Remove existing directory first
      if fs_exists(spec.path) then
        rm_rf(spec.path)
      end
      local okmv = pcall(uv.fs_rename, temp_path, spec.path)
      if not okmv then
        safe_notify("[plu] failed to move " .. spec.name, vim.log.levels.ERROR)
        rm_rf(temp_path)
        if on_done then on_done(false) end
        return
      end

      safe_notify("[plu] installed " .. spec.name .. (spec.version and ("@" .. spec.version) or ""))
      if on_done then on_done(true) end
    end

    -- Handle version checkout
    local function do_install()
      if spec.version and spec.version ~= nil then
        if spec.version == "*" then
          -- Get latest tag
          git_async({ "fetch", "--tags", "--force" }, temp_path, function()
            git_async({ "tag", "--sort=v:refname" }, temp_path, function(ok2)
              if not ok2 then
                safe_notify("[plu] failed to fetch tags for " .. spec.name, vim.log.levels.WARN)
                move_and_notify()
                return
              end

              local tags = vim.fn.systemlist({ "git", "-C", temp_path, "tag", "--sort=v:refname" })
              if vim.v.shell_error == 0 and #tags > 0 then
                git_async({ "checkout", tags[#tags] }, temp_path, move_and_notify)
              else
                move_and_notify()
              end
            end)
          end)
        else
          -- Checkout specific tag/commit
          git_async({ "fetch", "--tags", "--force" }, temp_path, function()
            git_async({ "checkout", spec.version }, temp_path, function(ok2)
              if not ok2 then
                safe_notify("[plu] failed to checkout version " .. spec.version, vim.log.levels.ERROR)
                rm_rf(temp_path)
                if on_done then on_done(false) end
                return
              end

              if fs_exists(spec.path) then rm_rf(spec.path) end

              local okmv = pcall(uv.fs_rename, temp_path, spec.path)
              if not okmv then
                safe_notify("[plu] failed to move " .. spec.name, vim.log.levels.ERROR)
                rm_rf(temp_path)
                if on_done then on_done(false) end
                return
              end

              safe_notify("[plu] installed " .. spec.name .. "@" .. spec.version)
              if on_done then on_done(true) end
            end)
          end)
        end
      else
        move_and_notify()
      end
    end

    do_install()
  end)
end

local function update_plugin_async(spec, on_done)
  local url = resolve_url(spec.src)
  local temp_path = spec.path .. ".tmp." .. tostring(math.random(10000, 99999))

  git_async({ "clone", "--depth=1", "--quiet", url, temp_path }, nil, function(ok)
    if not ok then
      safe_notify("[plu] failed to update " .. spec.name, vim.log.levels.ERROR)
      rm_rf(temp_path)
      if on_done then on_done(false) end
      return
    end

    local okmv = pcall(uv.fs_rename, temp_path, spec.path .. ".new")
    if okmv then
      rm_rf(spec.path)
      pcall(uv.fs_rename, spec.path .. ".new", spec.path)
    else
      rm_rf(temp_path)
    end

    safe_notify("[plu] updated " .. spec.name)
    if on_done then on_done(true) end
  end)
end

local function source_plugin_files()
  vim.schedule(function()
    pcall(vim.cmd, "silent! runtime plugin/*.lua")
    pcall(vim.cmd, "silent! runtime plugin/*.vim")
    pcall(vim.cmd, "silent! runtime plugin/**/*.lua")
    pcall(vim.cmd, "silent! runtime plugin/**/*.vim")
  end)
end

local function run_config(spec)
  if type(spec.config) == "function" then
    local ok, err = pcall(spec.config)
    if not ok then
      safe_notify("[plu] config failed for " .. spec.name .. ": " .. tostring(err), vim.log.levels.ERROR)
    end
  end
end

local function load_plugin(spec)
  if spec._loaded then return true end

  if not fs_exists(spec.path) then
    safe_notify("[plu] plugin not installed: " .. spec.name, vim.log.levels.WARN)
    install_plugin_async(spec, function(ok)
      if ok then safe_notify("[plu] installed " .. spec.name .. " (background). Trigger again.") end
    end)
    return false
  end

  vim.opt.rtp:append(spec.path)
  source_plugin_files()


  vim.schedule(function()
    local ok, mod = pcall(require, spec.name)

    if ok then
      package.loaded[spec.name] = mod  -- final module
      if type(mod) == "table" and type(mod.setup) == "function" then
        pcall(mod.setup)
      end
    else
      -- fallback empty table so subsequent require() works
      package.loaded[spec.name] = {}
    end

    spec._loaded = true

    -- Run config AFTER marking as loaded to avoid recursion
    run_config(spec)
  end)


  return true
end

local function create_cmd_stub(spec, cmd)
  vim.api.nvim_create_user_command(cmd, function(opts)
    local loaded = load_plugin(spec)
    if not loaded then
      safe_notify("[plu] installing " .. spec.name .. " in background", vim.log.levels.INFO)
      return
    end
    local args = opts.args or ""
    vim.schedule(function()
      pcall(vim.cmd, cmd .. (args ~= "" and " " .. args or ""))
    end)
  end, { nargs = "*", bang = true, complete = "file" })
end

local function create_key_stub(spec, mode, lhs)
  local rhs = lhs
  vim.keymap.set(mode, lhs, function()
    local loaded = load_plugin(spec)
    if not loaded then
      safe_notify("[plu] installing " .. spec.name .. " in background", vim.log.levels.INFO)
      return
    end
    local seq = vim.api.nvim_replace_termcodes(rhs, true, false, true)
    vim.api.nvim_feedkeys(seq, "n", false)
  end, { noremap = false, silent = true })
end

local function create_event_stub(spec, ev, pattern)
  vim.api.nvim_create_autocmd(ev, {
    pattern = pattern or "*",
    once = spec.once or false,
    callback = function()
      load_plugin(spec)
    end,
  })
end

local function create_ft_stub(spec, pattern)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = pattern or "*",
    once = true,
    callback = function()
      load_plugin(spec)
    end,
  })
end

function M.add(specs)
  if type(specs) == "string" or (type(specs) == "table" and specs.src) then
    registry[#registry + 1] = normalize(specs)
    return
  end

  if type(specs) == "table" then
    for _, s in ipairs(specs) do
      registry[#registry + 1] = normalize(s)
    end
    return
  end

  error("plu.add(): invalid input type " .. type(specs))
end

function M.setup()
  if #registry == 0 then return end

  -- Clean up old temp files first
  local handle = uv.fs_scandir(data_path)
  if handle then
    while true do
      local name = uv.fs_scandir_next(handle)
      if not name then break end
      if name:match("%.tmp%.%d+$") then
        local temp_path = data_path .. name
        rm_rf(temp_path)
      end
    end
  end

  local missing = {}
  for _, spec in ipairs(registry) do
    if not fs_exists(spec.path) then
      missing[#missing + 1] = spec
    end
  end

  if #missing > 0 then
    -- Show installation dialog
    local msg = "[plu] Installing " .. #missing .. " plugins:\n"
    for _, spec in ipairs(missing) do
      local version_info = spec.version and ("@" .. spec.version) or ""
      msg = msg .. "  • " .. spec.name .. version_info .. "\n"
    end
    vim.notify(msg, vim.log.levels.INFO)

    -- Install missing plugins
    for _, spec in ipairs(missing) do
      install_plugin_async(spec, function() end)
    end
  end

  for _, spec in ipairs(registry) do
    local exists = fs_exists(spec.path)

    if spec.lazy then
      if spec.keys then
        local keys_list = spec.keys
        if type(spec.keys) == "string" then
          keys_list = { spec.keys }
        end
        for _, k in ipairs(keys_list) do
          create_key_stub(spec, "n", k)
        end
      end

      if spec.cmd then
        if type(spec.cmd) == "string" then
          create_cmd_stub(spec, spec.cmd)
        else
          for _, c in ipairs(spec.cmd) do
            create_cmd_stub(spec, c)
          end
        end
      end

      if spec.event then
        if type(spec.event) == "string" then
          create_event_stub(spec, spec.event)
        else
          for _, e in ipairs(spec.event) do
            create_event_stub(spec, e)
          end
        end
      end

      if spec.ft then
        if type(spec.ft) == "string" then
          create_ft_stub(spec, spec.ft)
        else
          for _, f in ipairs(spec.ft) do
            create_ft_stub(spec, f)
          end
        end
      end

      -- If lazy but no specific triggers, use UIEnter as default
      if not spec.keys and not spec.cmd and not spec.event and not spec.ft then
        create_event_stub(spec, "UIEnter")
      end

    else
      if not exists then
        vim.fn.mkdir(vim.fn.fnamemodify(spec.path, ":h"), "p")
        -- Don't use depth=1 when we need a specific version
        local clone_args = spec.version and
          {"git", "clone", "--quiet", resolve_url(spec.src), spec.path} or
          {"git", "clone", "--depth=1", "--quiet", resolve_url(spec.src), spec.path}

        vim.fn.system(clone_args)

        if spec.version then
          -- Fetch tags first
          vim.fn.system({"git", "-C", spec.path, "fetch", "--tags", "--force"})

          if spec.version == "*" then
            local tags = vim.fn.systemlist({
              "git", "-C", spec.path, "tag", "--sort=v:refname"
            })
            if #tags > 0 then
              vim.fn.system({"git", "-C", spec.path, "checkout", tags[#tags]})
            end
          else
            vim.fn.system({"git", "-C", spec.path, "checkout", spec.version})
          end
        end
      end

      load_plugin(spec)
    end
  end
end

function M.update()
  for _, spec in ipairs(registry) do
    if fs_exists(spec.path) then
      update_plugin_async(spec, function() end)
    else
      safe_notify("[plu] not installed: " .. spec.name)
    end
  end
end

return M

