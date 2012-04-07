if exists('smarty_left_delimiter')
  let b:smarty_left_delimiter = smarty_left_delimiter
else
  let b:smarty_left_delimiter = '{'
endif

if exists('smarty_right_delimiter')
  let b:smarty_right_delimiter = smarty_right_delimiter
else
  let b:smarty_right_delimiter = '}'
endif

" "syntax keyword smartyBool contained true,on,yes,false,off,no

syntax match smartyVarSelector contained "\$"
syntax match smartyIdent contained "$\h\w*" contains=smartyVarSelector,smartyReserved
syntax match smartyIdent contained "\.\h\w*"
syntax match smartyIdent contained "->\h\w*"
syntax match smartyIdent contained "\[\w*\]"

syntax region smartyString contained start=+'+ skip=+\\\\\|\\'+ end=+'+
syntax region smartyString contained start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=smartyBacktick
syntax region smartyBacktick contained start=+`+ end=+`+ contains=smartyIdent

execute "syntax region smartyZone matchgroup=Delimiter"
      \ . " start=+" . b:smarty_left_delimiter . "/\\?+"
      \ . " end=+" . b:smarty_right_delimiter . "+"
      \ . " contains=smartyProperty, smartyString, smartyBlock, smartyTagName,"
      \ . " smartyConstant, smartyInFunc, smartyModifier, htmlString, smartyIdent, smartyReserved"

execute "syntax region Comment start=+" . b:smarty_left_delimiter
      \ . "\\*+ end=+\\*" . b:smarty_right_delimiter . "+"

syntax region  htmlTag                start=+<[^/]+   end=+>+ contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster,smartyZone
"highlight link smartyZone Include
highlight link smartyString String
highlight link smartyBacktick Function
highlight link smartyTagName Type
highlight link smartyIdent Identifier
highlight link smartyReserved Constant
highlight link smartyVarSelector Statement
