" Set the python dictionary location on runtime
let $VIMHOME=expand("<sfile>:p:h:h")
let g:pydiction_location=$VIMHOME.'/dict/python-complete-dict'
