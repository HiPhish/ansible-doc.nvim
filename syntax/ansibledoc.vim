if exists('b:current_syntax')
  finish
endif

syntax case  ignore

syntax match ansibledocSectionHeading display '\v^(\w+\s*)+\ze.*'
syntax match ansibledocHeader         display '\v^MODULE\s\S+'
syntax match ansibledocCode           display "\v'[^']+'"

" Special inline-syntax markers;
syntax region ansibledocModule  concealends matchgroup=Conceal start='\vM\(' end='\v\)'
syntax region ansibledocCode    concealends matchgroup=Conceal start='\vC\(' end='\v\)'
syntax region ansibledocOption  concealends matchgroup=Conceal start='\vO\(' end='\v\)'
syntax region ansibledocEmph    concealends matchgroup=Conceal start='\vB\(' end='\v\)'
syntax region ansibledocLiteral concealends matchgroup=Conceal start='\vV\(' end='\v\)'

highlight default link ansibledocHeader         Title
highlight default link ansibledocSectionHeading Statement
highlight default link ansibledocModule         Underlined
highlight default link ansibledocCode           Comment
highlight default link ansibledocOption         Type
highlight default link ansibledocLiteral        Constant
highlight default      ansibledocEmph           cterm=italic gui=italic


" Highlight the option definitions inside the OPTIONS block the same as inline
" options
syntax match ansibledocOption '\v  \w+$' contained 
syntax region ansibledocOptions matchgroup=ansibledocSectionHeading
	\ start='\v^OPTIONS'
	\ end='\v\ze^\w+.*$'
	\ contains=ansibledocOption


" This file might have been sourced as part of some some other syntax file.
" If that is the case we have to stop here to avoid undesirable side effects.
if &filetype != 'ansibledoc'
  finish
endif

" The Examples section contains raw YAML code.
syntax case match
syntax include @yaml $VIMRUNTIME/syntax/yaml.vim

" syntax region ansidocExample start='\v^EXAMPLES:$' end='\v^\w+.*:$' keepend contains=@c
syntax region ansidocExample matchgroup=ansibledocSectionHeading
	\ start='\v^EXAMPLES\ze$'
	\ end='\v\ze^\w+.*$'
	\ contains=@yaml
