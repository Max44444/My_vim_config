filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " проводник файловой системы
Plugin 'ycm-core/YouCompleteMe' " автодополнение кода и контроль ощибок (необходим clang)
Plugin 'jiangmiao/auto-pairs' " автодополнение парных символов  (), [], {} и т.д
Plugin 'tpope/vim-fugitive' " команды git в vim (необходим git)
Plugin 'airblade/vim-gitgutter' " интеграция с git
Plugin 'kien/ctrlp.vim' " быстрый поиск файлов для vim
Plugin 'easymotion/vim-easymotion' " быстрое перемещение по файлу
Plugin 'vim-airline/vim-airline' " улучшеная строка состояния
Plugin 'majutsushi/tagbar' " список тегов присутствующем в текущем буфере
Plugin 'terryma/vim-multiple-cursors' " мультикурсор как в sublimetext
Plugin 'rhysd/vim-clang-format' " форматирование файла (необходим clang-format)
Plugin 'tpope/vim-surround' " плагин для легкого удаления, изменения и добавления парных символов
Plugin 'ryanoasis/vim-devicons' " красивые иконки в плагинах

"colorschems
Plugin 'morhetz/gruvbox'
Plugin 'mhartington/oceanic-next'
Plugin 'sainnhe/edge'

Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on

set nocompatible " отключить режим совместимости с классическим Vi 
set exrc " искать дополнительный .vimrc в текущей рабочей директории
set secure "запрещает внешним .vimrc писать что-то в файлы, выполнять комманды шелла и отображает маппинги, которые создаются
set number " включить нумерацию строк
set expandtab " преобразовать табуляцию в пробелы
set tabstop=4 " ширина табуляции
set softtabstop=4 " ширина 'мягкого' таба
set shiftwidth=4 " размер отступов
set hlsearch " подсветка результатов поиска
set incsearch " поиск фрагмента по мере его набора
syntax on " включить подсветку синтаксиса
set cursorline " подсвечивать местоположение курсора
set showcmd " показывать незавершенные команды в статусбаре (автодополнение ввода)
set termguicolors " поддержка цветов для терминала
set mousehide " скрывать мышь в режиме ввода текста
set ignorecase " поиск без учёта регистра символов
set smartcase " - если искомое выражения содержит символы в верхнем регистре - ищет с учётом регистра, иначе - без учёта
set linebreak " переносить целые слова
set foldenable " включить фолдинг
set foldmethod=syntax " определять блоки на основе синтаксиса файла
set foldmethod=indent " определять блоки на основе отступов
"set foldcolumn=3 " показать полосу для управления сворачиванием
set foldlevel=1 " Первый уровень вложенности открыт, остальные закрыты
set path=.,,**,/src,/usr/local " путь для поиска файлов командами gf, [f, ]f, ^Wf, :find, :sfind, :tabfind и т.д.
set t_Co=256 " использовать больше цветов в терминале
let mapleader = ','

if (has("termguicolors"))
   set termguicolors
endif

" настройка цветовой схемы
colorscheme edge
"colorscheme OceanicNext
"colorschem gruvbox
set background=dark
let g:edge_style = 'neon'
let g:edge_disable_italic_comment = 1
let g:airline_theme = 'edge'
let g:edge_popup_menu_selection_background = 'green'

"mappings
map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)
map <F8> :TagbarToggle<CR>
imap <F8> <Esc>:TagbarToggle<CR>i
vmap <F8> <Esc>:TagbarToggle<CR>v
map <C-f> :ClangFormat<CR>
imap <C-f> <Esc>:ClangFormat<CR>i
vmap <C-f> <Esc>:ClangFormat<CR>v
map <C-t> :!tmux split-window -v<CR><CR>

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

" создание и переход между окнами 
map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key, '[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

"Vim-Airline
set laststatus=2
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
" don't show buffers names if open only one file<
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_powerline_fonts = 1
let g:airline_section_z = "\ue0a1:%l/%L Col:%c"
let g:Powerline_symbols='unicode'
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" путь поиска совпадений для плагина clang
let g:clang_library_path='/usr/lib/llvm-6.0/lib'

"multiple cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-m>'
let g:multi_cursor_select_all_word_key = '<A-m>'
let g:multi_cursor_start_key           = 'g<C-m>'
let g:multi_cursor_select_all_key      = 'g<A-m>'
let g:multi_cursor_next_key            = '<C-m>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" изменение курсора в разных режимах
let &t_SI.="\e[5 q"
let &t_SR.="\e[3 q"
let &t_EI.="\e[1 q"
