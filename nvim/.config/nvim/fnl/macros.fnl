; Import and reexport macros from nvim-laurel
; See https://github.com/aileot/nvim-laurel/blob/main/docs/reference.md
(local {: let!
        : g!
        : b!
        : w!
        : t!
        : v!
        : env!
        : map!
        : unmap!
        : <C-u>
        : <Cmd>
        : command!
        : augroup!
        : au!
        : autocmd!
        : feedkeys!
        : set!
        : highlight!
        : hi!} (require :laurel.macros))

;; TODO should return values, maybe rename to `?`
(fn dbg! [...]
  `(print (vim.inspect ,...)))

; Annoying to pass :buffer params, this is a shortcut.
(fn bmap! [...]
  (map! `&default-opts {:buffer 0} ...))

(fn tx! [& args]
  "Mixed sequential and associative tables at compile time. Because the Neovim ecosystem loves them but Fennel has no neat way to express them (which I think is fine, I don't like the idea of them in general)."
  (let [to-merge (when (table? (. args (length args)))
                   (table.remove args))]
    (if to-merge
        (do
          (each [key value (pairs to-merge)]
            (tset args key value))
          args)
        args)))

;; TODO: doesnt support mini.pick builtin.files for example
(fn m [m func ...]
  "Call a function on a module"
  (assert-compile (sym? m) "expected module name")
  (assert-compile (sym? func) "expected function name")
  `((. (require ,(tostring m)) ,(tostring func)) ,...))

{: tx!
 : let!
 : g!
 : b!
 : w!
 : t!
 : v!
 : env!
 : map!
 : bmap!
 : unmap!
 : <C-u>
 : <Cmd>
 : command!
 : augroup!
 : au!
 : autocmd!
 : feedkeys!
 : set!
 : highlight!
 : hi!
 : dbg!
 : m}
