(require-macros :macros)

; Define leader key as early as possible as some plugins may not work if they're loaded before
; the leader is defined.
(g! :mapleader " ")
(g! :maplocalleader ",")

;; Then load all plugins so the rest of the configuration can reference them if needed to.
(require :plugins)

;; Finally the rest of the configuration.
(vim.cmd.colorscheme "melange")
(vim.cmd "packadd nvim.undotree")

(set! :mouse "")
(set! :guicursor "n-v-i-c:block-Cursor")
(set! :wrap true)
(set! :linebreak true)
(set! :cursorline true)
(set! :number true)
(set! :relativenumber true)
(set! :ignorecase true)
(set! :smartcase true)
(set! :signcolumn "yes")
(set! :scrolloff 8)
(set! :sidescrolloff 8)
(set! :completeopt "menu,menuone,noselect")

(g! :loaded_python3_provider 0)
(g! :loaded_node_provider 0)
(g! :loaded_perl_provider 0)
(g! :loaded_ruby_provider 0)

(local util (require :util))
(map! :i "<C-l>" "λ" {:desc "Insert lambda symbol"})
(map! :nvx :<leader>y "\"+y<CR>" {:desc "Yank to clipboard"})
(map! :nvx :<leader>d "\"+d<CR>" {:desc "Delete to clipboard"})
(map! :n :<Tab> :<cmd>bnext<CR> {:desc "Switch to next buffer"})
(map! :n :<S-Tab> :<cmd>bprevious<CR> {:desc "Switch to previous buffer"})
(map! :n "<leader>u"
      #(m undotree open {:command "topleft 30vnew"}
      {:desc "Open undotree"}))
(map! :n "<leader>f" ":Pick files<CR>" {:desc "Find files"})
(map! :n "<leader>g" ":Pick grep_live<CR>"  {:desc "Live grep"})
(map! :n "<leader>b" ":Pick buffers<CR>" {:desc "Buffers"})
(map! :n "<leader>\\"
      #(do
         (vim.cmd.vnew)
         (vim.cmd.term)
         (vim.cmd.wincmd "J"))
      {:desc "Open vertical terminal"})
(map! :n "-" ":Fyler<CR>" {:desc "Open file explorer"})
(map! :n "<localleader>d"
        #(util.insert-date "%Y-%m-%d")
        {:desc "Insert current date"})

;; LSP Config
(vim.diagnostic.config {:virtual_lines {:current_line true}})
(vim.lsp.enable ["clangd"
                 "lua_ls"
                 "vtsls"
                 "pyright"
                 "gopls"
                 "rust_analyzer"
                 "zls"
                 "jdtls"
                 "fennel_ls"
                 "clojure_lsp"])
;; Native LSP hints
(vim.lsp.inlay_hint.enable true)
(augroup! :my-lsps
 (au! :LspAttach
      #(do
          ;; LSP keymaps
          (bmap! :n "gd" vim.lsp.buf.definition)
          (bmap! :n "<leader>ca" vim.lsp.buf.code_action)
          (bmap! :n "<leader>rn" vim.lsp.buf.rename))))


(augroup! :line-num-only-in-active-windows
 (au! :WinEnter #(do
                   (let! :wo :number true)
                   (let! :wo :relativenumber true)))
 (au! :WinLeave #(do
                   (let! :wo :number false)
                   (let! :wo :relativenumber false))))

(local nvim-treesitter (require :nvim-treesitter))
;; ignore auto install for these filetypes:
(local ignored_ft ["mininotify"])

(augroup! :treesitter
         (au! :filetype
               (λ [args]
                 (local bufnr args.buf)
                 (local ft args.match)
                 ;; auto install grammars unless explicitly ignored.
                 (when (not (vim.list_contains ignored_ft ft))
                   (: (nvim-treesitter.install ft) :await
                      (λ []
                        (local installed (nvim-treesitter.get_installed))
                        (when (and (vim.api.nvim_buf_is_loaded bufnr)
                                   (vim.list_contains installed ft))
                          ;; enable highlight only if there's an installed grammar.
                          (vim.treesitter.start bufnr))))))))

