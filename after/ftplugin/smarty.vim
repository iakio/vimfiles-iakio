
if exists("b:did_ftplugin") | finish | endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim
let b:did_ftplugin = 1

if exists("loaded_matchit")
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

	let b:block_tags = [
				\ [ "capture", "/capture" ],
				\ [ "foreach", "foreachelse", "/foreach"],
				\ [ "if", "elseif", "else", "/if" ],
				\ [ "literal", "/literal" ],
				\ [ "section", "/section" ],
				\ [ "strip", "/strip" ],
				\ ]

	let b:words = ""

	for b:pair in b:block_tags
		if b:words != ""
			let b:words .= ","
		endif

		let b:isfirst = 1
		for b:tag in b:pair
			if b:isfirst
				let b:isfirst = 0
			else
				let b:words .= ':'
			endif
			let b:words .= b:smarty_left_delimiter . '\s*' . b:tag . '\>'
		endfor
	endfor
	let b:match_words .= "," . b:words
endif
