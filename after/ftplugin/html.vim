setlocal indentexpr=
inoremap <buffer> <expr> / getline(".")[col(".") -2] == "<" ? "/<C-x><C-o>" : "/"
