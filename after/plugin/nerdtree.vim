let NERDTreeShowHidden = 1
let NERDTreeWinSize = 50
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = ['dist$', 'node_modules$', '\.vscode$', '\.idea$', '\.git$', '\.github', '.sass-cache', '\.DS_Store', '\.serverless$', '\.nyc_output$', 'coverage', '\.un\~$']
let NERDTreeNodeDelimiter = "\u00a0"

nnoremap <silent> <Leader><Space> :NERDTreeFind<Cr>
