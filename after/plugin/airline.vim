let g:airline_exclude_preview=1
let g:airline_section_a = '' " do not show the mode
let g:airline_section_z = '%l/%L:%3v'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" let g:airline_extensions = ['branch', 'fugitiveline', 'gina']
let g:airline_stl_path_style = 'short'

" for airline inactive mode
let g:airline_theme_patch_func = 'AirlineThemePatch'

function! AirlineThemePatch(palette)
  for colors in values(a:palette.inactive)
    " The colors array has the following elements:
    "   [guifg, guibg, ctermfg, ctermbg, opts]
    " Using '' should get them back to the default values.
    let colors[0] = '#c6c6c6'
    let colors[2] = '251'
  endfor
endfunction
