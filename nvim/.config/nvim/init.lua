vim.loader.enable()

-- Clear Fennel cache when Fennel dependencies are changed.
local rebuild_thyme = false

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local name = event.data.spec.name

    if name == "nvim-thyme" or name == "nvim-laurel" then
      rebuild_thyme = true
    end
  end,
  group = vim.api.nvim_create_augroup("init.lua", { clear = true }),
})

-- vim.pack installs into `~/.local/share/nvim/site/pack/core/opt/` by default
-- while adding them to &runtimepath.
vim.pack.add({
  -- Fennel environment and compiler.
  "https://git.sr.ht/~technomancy/fennel",
  "https://github.com/aileot/nvim-thyme",
  -- Gives us some pleasant fennel macros.
  "https://github.com/aileot/nvim-laurel",
  -- Enables lazy loading of plugins.
  "https://github.com/BirdeeHub/lze",
}, { confirm = false })

-- Ensure fennel plugin gets compiled
local fennel_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/fennel"
local out = vim.fn.system("make -C " .. fennel_path)
if vim.v.shell_error ~= 0 then error("Fennel compile failed:\n" .. out) end

-- Override package loading so thyme can hook into `require` calls and generate lua code
-- if the required package is a fennel file.
table.insert(package.loaders, function(...)
  return require("thyme").loader(...)
end)

-- Setup the compile cache path that thyme requires.
local thyme_cache_prefix = vim.fn.stdpath("cache") .. "/thyme/compiled"
vim.opt.rtp:prepend(thyme_cache_prefix)

require("thyme").setup()

-- Rebuild thyme cache after `vim.pack.add` to avoid dependency issues
-- and to make sure all packages are loaded.
if rebuild_thyme then
  vim.cmd("ThymeCacheClear")
end

-- Load the rest of the config with transparent fennel support.
require("config")
