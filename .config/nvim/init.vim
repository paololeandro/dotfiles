call plug#begin()

Plug 'sheerun/vim-polyglot'

Plug 'vim-airline/vim-airline'

Plug 'morhetz/gruvbox'

Plug 'dense-analysis/ale'

Plug 'jiangmiao/auto-pairs'

call plug#end()

set number

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

autocmd vimenter * ++nested colorscheme gruvbox
