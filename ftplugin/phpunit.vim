setlocal makeprg=phpunit

" ...IPHP Fatal error:  Call to undefined method foo() in
" /pat/to/MyTest.php on line 100
"
setlocal errorformat=
			\%-GPHPUnit\ %\[0-9.]%\\+\ by\ Sebastian\ Bergmann.,
			\%-G,
			\%-GTime:\ %\\d%.%#,
			\%-GThere\ was\ %\\d%\\+\ failure:,
			\%-G%[.EFI]%#,
			\%-GConfiguration\ read\ from%.%#,
			\%E%\\d%\\+)\ %.%#,
			\%Z%f:%l,
			\%[.EFI]%#PHP\ %.%#\ %trror:%m\ in\ %f\ on\ line\ %l,
			\PHP%.%#\ %f:%l,
			\%C%m
