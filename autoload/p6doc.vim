function! p6doc#complete(arglead, cmdline, cursorpos)
  let doc = {}
  for path in s:p6inc
    for k in filter(map(split(globpath(path, '**/*.pod'), "\n"), 'substitute(v:val[len(fnamemodify(path,":p")):], "[\\/]", "::", "g")[:-5]'), 'v:val!~"^\\(site\\|lib\\|vendor\\)"')
      let doc[k] = 1
    endfor
  endfor
  return filter(sort(keys(doc)), 'stridx(v:val, a:arglead)==0')
endfunction

function! p6doc#run(arg)
  silent new
  setlocal filetype=man
  setlocal bufhidden=delete
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal nobuflisted
  setlocal modifiable
  setlocal nocursorline
  setlocal nocursorcolumn
  setlocal iskeyword+=:
  setlocal iskeyword-=-
  call setline('.', split(system('p6doc ' . a:arg), "\n"))
endfunction

if !exists('s:p6inc')
  let s:p6inc = map(map(split(system('perl6 -e "say join(q/,/,@*INC)"'), ','), 'substitute(v:val, "^\\w\\+#", "", "g")'), 'fnamemodify(v:val, ":p:gs!\\!/!g")')
endif
