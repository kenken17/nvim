lua require("defaults")
lua require("mappings")
lua require("plugins")
lua require("lsp")
lua require("snippets")
lua require("autocmds")

colorscheme simple

" For Ag
if executable("ag")
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  endif
endif

" folding workaround
function FoldConfig()
	set foldmethod=expr
	set foldexpr=nvim_treesitter#foldexpr()
endfunction

autocmd BufAdd,BufEnter,BufNew,BufNewFile,BufWinEnter * :call FoldConfig()
