if !executable('p6doc')
  finish
endif
command! -nargs=1 -complete=customlist,p6doc#complete P6doc call p6doc#run(<f-args>)
