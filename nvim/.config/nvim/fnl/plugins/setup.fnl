[;; Sources `plugin` and `ftdetect` directories when lazy loading.
 "https://github.com/lumen-oss/rtp.nvim"
 ;; Colorscheme
 "https://github.com/savq/melange-nvim"
 ;; Treesitter
 {:src "https://github.com/nvim-treesitter/nvim-treesitter"
  :after_build #(vim.cmd "TSUpdate")}
 "https://github.com/nvim-treesitter/nvim-treesitter-context"
 "https://github.com/HiPhish/rainbow-delimiters.nvim"
 ;; REPL development
 "https://github.com/Olical/conjure"
 ;; Multiple cursors
 "https://github.com/mg979/vim-visual-multi"
 ;; LspConfig (preconfigured set lsps)
 {:src "https://github.com/neovim/nvim-lspconfig"
  :event [:BufReadPost :BufNewFile]}
 ;; Formatting and linting
 "https://github.com/nvimdev/guard.nvim"
 "https://github.com/nvimdev/guard-collection"
 ;; Mini plugin collection
 {:src "https://github.com/nvim-mini/mini.nvim"
  :version :main
  :lazy false
  :after (λ []
          (: (require :mini.ai) :setup {})
          (: (require :mini.cursorword) :setup {})
          (: (require :mini.notify) :setup {})
          (: (require :mini.pick) :setup {})
          (: (require :mini.pairs) :setup {})
          (: (require :mini.starter) :setup {})
          (: (require :mini.jump) :setup {})
          (: (require :mini.icons) :setup {})
          (: (require :mini.diff) :setup {})
          (: (require :mini.tabline) :setup {})
          (: (require :mini.surround) :setup {}))}
 ;; Completion
 {:src "https://github.com/saghen/blink.cmp"
  :version :v1.9.1
  :on_require :blink.cmp
  :event [:InsertEnter]
  :setup {:completion {:documentation {:auto_show true}}}}
 ;; Snippets
 {:src "https://github.com/rafamadriz/friendly-snippets"
  :dep_of :blink.cmp}
 ;; Stuff by tpope
 "https://github.com/tpope/vim-dispatch"
 "https://github.com/tpope/vim-fugitive"
 "https://github.com/tpope/vim-eunuch"
 "https://github.com/tpope/vim-vinegar"
  {:src "https://github.com/MeanderingProgrammer/render-markdown.nvim"
   :on_require :render-markdown
   :lazy false
   :setup {}}
   "https://github.com/mcauley-penney/visual-whitespace.nvim"
]
