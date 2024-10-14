if exists('b:current_syntax')
  finish
endif

syntax case  ignore

syntax match ansibledocCode   display "\v'[^']+'"
syntax match ansibledocString display '\v"[^"]+"'

" Special inline-syntax markers;
syntax region ansibledocModule  concealends matchgroup=Conceal start='\vM\(' end='\v\)'
syntax region ansibledocCode    concealends matchgroup=Conceal start='\vC\(' end='\v\)'
syntax region ansibledocOption  concealends matchgroup=Conceal start='\vO\(' end='\v\)'
syntax region ansibledocEmph    concealends matchgroup=Conceal start='\vI\(' end='\v\)'
syntax region ansibledocStrong  concealends matchgroup=Conceal start='\vB\(' end='\v\)'
syntax region ansibledocLiteral concealends matchgroup=Conceal start='\vV\(' end='\v\)'

highlight default link ansibledocHeader         Title
highlight default link ansibledocSectionHeading Statement
highlight default link ansibledocModule         Underlined
highlight default link ansibledocCode           Comment
highlight default link ansibledocString         String
highlight default link ansibledocOption         Type
highlight default link ansibledocOptionRequired Special
highlight default link ansibledocLiteral        Constant
highlight default      ansibledocEmph           cterm=italic gui=italic
highlight default      ansibledocStrong         cterm=bold   gui=bold
highlight default link ansibledocAttribute      Identifier
highlight default link ansibledocReturnVal      Identifier


" This file might have been sourced as part of some some other syntax file.
" If that is the case we have to stop here to avoid undesirable side effects.
if &filetype != 'ansibledoc'
  finish
endif

" The Examples section contains raw YAML code.
syntax case match
syntax include @yaml $VIMRUNTIME/syntax/yaml.vim

syntax region ansidocExample matchgroup=ansibledocSectionHeading
	\ start='\v^EXAMPLES\ze$'
	\ end='\v\ze^\w+.*$'
	\ contains=@yaml
