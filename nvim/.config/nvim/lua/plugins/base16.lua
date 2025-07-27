return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local p = {
      base00 = "#000000",
      base01 = "#161b22",
      base02 = "#21262d",
      base03 = "#484f58",
      base04 = "#6e7681",
      base05 = "#c9d1d9",
      base06 = "#ecf2f8",
      base07 = "#ffffff",
      base08 = "#ff7b72",
      base09 = "#d29922",
      base0A = "#e3b341",
      base0B = "#7ee787",
      base0C = "#79c0ff",
      base0D = "#a5d6ff",
      base0E = "#d2a8ff",
      base0F = "#ffa198",
    }
    vim.opt.termguicolors = true
    require("base16-colorscheme").setup(p)
  end
}
