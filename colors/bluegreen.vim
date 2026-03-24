
" Vim color file
" Maintainer:   
" Last Change: 
" URL:			 


" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="bluegreen"

if v:version >= 700
    hi Pmenu          gui=none   guifg=#eeeeee   guibg=#2e2e3f
    hi PmenuSel       gui=none   guifg=#eeeeee   guibg=#4e4e8f
    hi PmenuThumb     gui=none   guifg=#eeeeee   guibg=#6e6eaf
    hi PmenuSbar      gui=none   guifg=#eeeeee   guibg=#1e1e27

    hi SpellBad     gui=undercurl guisp=#cc6666
    hi SpellRare    gui=undercurl guisp=#cc66cc
    hi SpellLocal   gui=undercurl guisp=#cccc66
    hi SpellCap     gui=undercurl guisp=#66cccc

endif
    
"hi Normal	guifg=White guibg=#061A3E
hi Normal	guifg=#D0D0D0 guibg=#0A1D40

" highlight groups
hi Cursor	guibg=#D74141 guifg=#e3e3e3
"hi CursorLine guibg=#0C234D
hi CursorLine guibg=#0A1A50
hi CursorColumn guibg=#0C234D
hi ColorColumn guibg=#0D2043
hi LineNr guifg=#334C75
hi CursorLineNr guifg=#334C75
hi VertSplit guifg=#334C75 gui=none
hi Folded		guibg=#FFC0C0 guifg=black
hi FoldColumn	guibg=#800080 guifg=tan
"hi IncSearch	cterm=none ctermbg=blue ctermfg=grey guifg=slategrey guibg=khaki
"hi IncSearch	cterm=none ctermbg=black ctermfg=yellow guifg=yellow guibg=black 
hi IncSearch	guifg=#B0FFFF guibg=#2050D0 ctermfg=darkblue ctermbg=gray
hi ModeMsg guifg=#404040 guibg=#C0C0C0
hi MoreMsg guifg=darkturquoise guibg=#188F90
hi NonText guibg=#334C75 guifg=#9FADC5
hi Question	guifg=#F4BB7E
"hi Search	 guifg=#2050D0 guibg=#b0ffff ctermfg=darkblue ctermbg=gray
"hi Search guibg=#C0C0C0 guifg=#066060
hi Search guibg=#C0C0C0 guifg=#2050D0
hi SpecialKey	guifg=#BF9261
hi StatusLine	guibg=#004443 guifg=#c0ffff gui=none
hi StatusLineNC	guibg=#067C7B guifg=#004443 gui=bold
hi Title	guifg=#8DB8C3
"hi Visual gui=bold guifg=black guibg=#C0FFC0
"hi Visual gui=none guifg=#b0ffff guibg=#2050d0
hi Visual gui=none guifg=#eeeeee  guibg=#4e4e8f
hi WarningMsg	guifg=#F60000 gui=underline
hi Directory guifg=#ADCBF1

" syntax highlighting groups
hi Comment guifg=#DABEA2
hi Constant guifg=#72A5E4 
hi Identifier	guifg=#ADCBF1 
hi Statement guifg=#7E75B5 gui=none
hi PreProc guifg=#14F07C
hi Type	guifg=#A9EE8A gui=none
hi Special guifg=#EEBABA
hi Ignore	guifg=grey60
hi Todo	guibg=#0A1A50 guifg=#9C8C84 gui=reverse
"hi Todo	guifg=#EACEB2 guibg=#202030
