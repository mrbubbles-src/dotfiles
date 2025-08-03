call plug#begin('~/.local/share/nvim/plugged')
" Theme One Dark
Plug 'navarasu/onedark.nvim'

" Schnelle Dateisuche (FZF)
Plug 'junegunn/fzf.vim'

" Leichte, bunte Statuszeile
Plug 'itchyny/lightline.vim'

" Surround-Probleme fixen (z. B. .klammern um Zeichen)
Plug 'tpope/vim-surround'

" Git-Kommandos direkt im Editor
Plug 'tpope/vim-fugitive'

" Ordnerbaum-Explorer (Datei-Browser)
Plug 'preservim/nerdtree'

" Emmet in Vim
Plug 'mattn/emmet-vim'

" Multiple Cursors
Plug 'terryma/vim-multiple-cursors'
call plug#end()

" Theme Config
let g:onedark_config = {
    \ 'style': 'darker',
\}
colorscheme onedark

set number

nnoremap <C-b> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
