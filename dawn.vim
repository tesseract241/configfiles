" Vim color file
" Maintainer:   tesseract241
" Last Change:  02/11/2021
" URL:		    https://github.com/tesseract241/configfiles/dawn.vim

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="dawn"

" A good way to see what your colorscheme does is to follow this procedure:
" :w 
" :so % 
"
" Then to see what the current setting is use the highlight command.  
" For example,
" 	:hi Cursor
" gives
"	Cursor         xxx guifg=bg guibg=fg 
 	
" Uncomment and complete the commands you want to change from the default.

hi Normal           guifg=Thistle1      guibg=MystyRose3
hi NormalNC         guifg=Thistle3      guibg=Grey11
hi Cursor           guibg=Thistle3		
hi CursorLine       guibg=Purple4
hi Pmenu            guifg=White         guibg=DarkMagenta
hi PMenuSel         guifg=White         guibg=Magenta2
"hi CursorIM	    guifg=              guibg=
"hi Directory	    guifg=              guibg=
"hi DiffAdd		    guifg=              guibg=
"hi DiffChange	    guifg=              guibg=
"hi DiffDelete	    guifg=              guibg=
"hi DiffText	    guifg=              guibg=
hi ErrorMsg	        guifg=lightRed      guibg=MystyRose3
hi VertSplit	    guifg=Grey50        guibg=black
hi Folded		    guifg=SteelBlue     guibg=Grey11
"hi FoldColumn	    guifg=              guibg=
hi SignColumn       guifg=lightRed      guibg=Grey50
"hi IncSearch	    guifg=              guibg=
"hi LineNr		    guifg=              guibg=
hi MatchParen       guifg=Gold3         guibg=DarkOrange3
"hi ModeMsg		    guifg=              guibg=
"hi MoreMsg		    guifg=              guibg=
"hi NonText		    guifg=              guibg=
"hi Question	    guifg=              guibg=
"hi Search		    guifg=              guibg=
"hi SpecialKey	    guifg=              guibg=
"hi StatusLine	    guifg=black         guibg=white gui=bold,reverse
"hi StatusLineNC	    gui=reverse
"hi TabLine          guifg=white         guibg=Red
"hi TabLineFill      guifg=white         guibg=black
"hi TabLineSel       guifg=white         guibg=black
"hi Title		    guifg=red            guibg=white
hi Visual		    guibg=DeepPink4
"hi VisualNOS	    guifg=              guibg=
"hi WarningMsg	    guifg=              guibg=
"hi WildMenu	    guifg=              guibg=
"hi Menu		    guifg=              guibg=
"hi Scrollbar	    guifg=              guibg=
"hi Tooltip		    guifg=              guibg=

" syntax highlighting groups
hi Comment          guifg=Grey50        guibg=MystyRose3
hi Constant	        guifg=Orange4       gui=Italic
"hi Identifier	
hi Statement	    gui=bold    guifg=Yellow1
hi PreProc          guifg=IndianRed1	
hi Type		        guifg=Chartreuse3 gui=bold
"hi Special	
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		

