[;; Sources `plugin` and `ftdetect` directories when lazy loading.
 "https://github.com/lumen-oss/rtp.nvim"
 ;; Colorscheme
 "https://github.com/savq/melange-nvim"
 ;; Treesitter
 {:src "https://github.com/nvim-treesitter/nvim-treesitter"
  :after_build #(vim.cmd "TSUpdate")}
 "https://github.com/Olical/conjure"
 "https://github.com/mg979/vim-visual-multi"
 ;; LspConfig (preconfigured set lsps)
 {:src "https://github.com/neovim/nvim-lspconfig"
  :event [:BufReadPost :BufNewFile]}
 ;; Mini
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
          (: (require :mini.surround) :setup {}))}
 ;; Filemanager
 {:src "https://github.com/A7Lavinraj/fyler.nvim"
  :on_require :fyler
  :lazy false
  :setup {:views {:finder {:default_explorer true}}}}
 ;; Completion
 {:src "https://github.com/saghen/blink.cmp"
  :version :v1.8.0
  :on_require :blink.cmp
  :event [:InsertEnter]
  :setup {:completion {:documentation {:auto_show true}}}}
 ;; Snippets
 {:src "https://github.com/rafamadriz/friendly-snippets"
  :dep_of :blink.cmp}
 ;; Formatting
 {:src "https://github.com/stevearc/conform.nvim"
  :on_require :conform
  :event [:BufWritePre]
  :setup {:formatters_by_ft {:c [:clang-format]}
          :format_on_save {:timeout_ms 500
                           :lsp_format "fallback"}}}
 ;; Tpope
 "https://github.com/tpope/vim-dispatch"
 "https://github.com/tpope/vim-fugitive"
 ;; Orgmode
 {:src "https://github.com/nvim-orgmode/orgmode"
  :version :0.7.2
  :on_require :orgmode
  :lazy false
  :setup {:org_agenda_files "~/Sync/Org/**/*"
          :org_default_notes_file "~/Sync/Org/refile.org"}}
]
