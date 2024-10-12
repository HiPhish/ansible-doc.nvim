if exists('b:current_syntax')
  finish
endif

syntax case  ignore

syntax match ansibledocHeader         display '\v^MODULE\s\S+'
syntax match ansibledocSectionHeading display '\v^(\w+\s*)+\ze.*'
syntax match ansibledocCode           display "\v'[^']+'"

" List of special inline-syntax markers;
"   - M: Module name, this is like a hyperlink
"   - C: Code
"   - O: Option
"   - B: Emphasis (bold)
"   - V: Literal value

highlight default link ansibledocHeader         Title
highlight default link ansibledocSectionHeading Statement
highlight default link ansibledocModule         Underlined
highlight default link ansibledocCode           Comment
highlight default link ansibledocOption         Type
highlight default link ansibledocLiteral        Constant
highlight default      ansibledocEmph           cterm=italic gui=italic

if &filetype != 'ansibledoc'
  finish |" May have been included by some other file type.
endif

" The Examples section contains raw YAML code.
syntax case match
syntax include @yaml $VIMRUNTIME/syntax/yaml.vim

" syntax region ansidocExample start='\v^EXAMPLES:$' end='\v^\w+.*:$' keepend contains=@c
syntax region ansidocExample matchgroup=ansibledocSectionHeading
	\ start='\v^EXAMPLES\ze$'
	\ end='\v\ze^\w+.*$'
	\ contains=@yaml
