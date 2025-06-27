let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/devops/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
argglobal
%argdel
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
enew
file NvimTree_1
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=wipe
setlocal nobuflisted
setlocal buftype=nofile
setlocal nocindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=0
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,fb:���
setlocal commentstring=
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeslash=
setlocal concealcursor=
setlocal conceallevel=0
setlocal nocopyindent
setlocal nocursorbind
setlocal nocursorcolumn
setlocal cursorline
setlocal cursorlineopt=both
setlocal nodiff
setlocal eventignorewin=
setlocal expandtab
if &filetype != 'NvimTree'
setlocal filetype=NvimTree
endif
setlocal fillchars=fold:\ 
setlocal fixendofline
setlocal foldcolumn=0
setlocal nofoldenable
setlocal foldexpr=v:lua.vim.fold.foldexpr()
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=v:lua.require'ufo.main'.foldtext()
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=tcqj
setlocal iminsert=0
setlocal imsearch=-1
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal nolinebreak
setlocal nolisp
setlocal lispoptions=
setlocal nolist
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal nomodifiable
setlocal nrformats=bin,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal shiftwidth=2
setlocal signcolumn=yes
setlocal smartindent
setlocal nosmoothscroll
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\\t\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statuscolumn=
setlocal statusline=%#lualine_a_normal#\ NORMAL\ %#lualine_transitional_lualine_a_normal_to_lualine_b_normal#%#lualine_b_normal#\ \ master\ %#lualine_transitional_lualine_b_normal_to_lualine_c_normal#%<%#lualine_c_normal#\ /Users/kalbyimanie/.config/devops/nvim/NvimTree_1\ [-]\ %#lualine_c_normal#%=%#lualine_c_normal#\ \ %#lualine_x_filetype_DevIconDefault_normal#\ \ %#lualine_c_normal#NvimTree\ %#lualine_transitional_lualine_b_normal_to_lualine_c_normal#%#lualine_b_normal#\ Top\ %#lualine_transitional_lualine_a_normal_to_lualine_b_normal#%#lualine_a_normal#\ \ \ 1:3\ \ 
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'NvimTree'
setlocal syntax=NvimTree
endif
setlocal tabstop=2
setlocal tagfunc=
setlocal textwidth=0
setlocal noundofile
setlocal varsofttabstop=
setlocal vartabstop=
setlocal winblend=0
setlocal nowinfixbuf
setlocal winfixheight
setlocal winfixwidth
setlocal winhighlight=EndOfBuffer:NvimTreeEndOfBuffer,CursorLine:NvimTreeCursorLine,CursorLineNr:NvimTreeCursorLineNr,LineNr:NvimTreeLineNr,WinSeparator:NvimTreeWinSeparator,StatusLine:NvimTreeStatusLine,StatusLineNC:NvimTreeStatuslineNC,SignColumn:NvimTreeSignColumn,Normal:NvimTreeNormal,NormalNC:NvimTreeNormalNC,NormalFloat:NvimTreeNormalFloat,FloatBorder:NvimTreeNormalFloatBorder
setlocal nowrap
setlocal wrapmargin=0
lcd ~/.config/devops/nvim
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
