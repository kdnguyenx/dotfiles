setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
" set path and format
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal errorformat=[ERROR]\ %f:[%l\\,%v]\ %m
setlocal makeprg=mvn\ clean\ install\ -T\ 5
setlocal path+=src/main/java/**
setlocal path+=src/main/test/**
setlocal path+=**/src/main/java/**
setlocal path+=**/src/main/test/**
