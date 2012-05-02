if &filetype == 'html'
	setlocal indentexpr=
endif
inoremap <buffer> <expr> / getline(".")[col(".") -2] == "<" ? "/<C-x><C-o>" : "/"
