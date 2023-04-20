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

if has('unix')
  let is_wsl = system('uname -a') =~ 'microsoft'

  if is_wsl
    let g:clipboard = {
      \   'name': 'WslClipboard',
      \   'copy': {
      \	'+': 'clip.exe',
      \	'*': 'clip.exe',
      \   },
      \   'paste': {
      \	'+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r", ""))',
      \	'*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).toString().replace("`r", ""))',
      \   },
      \   'cache_enabled': 0,
      \ }
  endif
endif

" "Aliases" for commonly used commands (fat finger):
command! -bar -nargs=* -complete=file -range=% -bang W         <line1>,<line2>write<bang> <args>
command! -bar -nargs=* -complete=file          -bang E         edit<bang> <args>
command! -bar                                  -bang Q         quit<bang>
