
syntax match phpEolError ";$" contained display

syntax region phpClosure matchgroup=Delimiter
	\ start="\(function\s*(.*)\s*\)\@<={" end="}"
	\ contained contains=@phpClInside

syntax region phpParent matchgroup=Delimiter
	\ start="(" end=")"
	\ contained contains=@phpClInside,phpClosure,phpEolError transparent

highlight link phpEolError Error
