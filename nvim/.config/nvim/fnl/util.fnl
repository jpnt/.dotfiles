(λ insert-date [fmt]
   (vim.api.nvim_put [(os.date fmt)] "c" true true))

{: insert-date}
