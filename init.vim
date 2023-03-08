lua require("defaults")
lua require("mappings")
lua require("plugins")
lua require("lsp")
lua require("snippets")
lua require("autocmds")

colorscheme simple

" For Rg
if executable("rg")
  " Use rg over grep
  " set grepprg=rg\ --nogroup\ --nocolor
  set grepprg=rg\ --vimgrep\ --no-heading

  if !exists(":Rg")
    command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
  endif
endif

" folding workaround
function FoldConfig()
	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
endfunction

autocmd BufAdd,BufEnter,BufNew,BufNewFile,BufWinEnter * :call FoldConfig()
