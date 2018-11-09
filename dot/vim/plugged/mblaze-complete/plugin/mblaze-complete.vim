" Complete mail addr with custom mail addr dict (mcpl)
if exists("g:mblaze_complete")
  finish
else
  let g:mblaze_complete = 1
endif

function! CompleteAddress(findstart, base)
  let curline = getline('.')
  if curline =~ '^From: ' || curline =~ '^To: ' || curline =~ '^Cc: ' || curline =~ '^Bcc: '
    if a:findstart
      " locate the start of the word
      let header_limit = stridx(curline, ": ") + 2 " Find end of the header
      let start = col('.') - 1
      while start > header_limit && curline[start - 2] != ","
        let start -= 1
      endwhile
      return start
    else
      let query=shellescape(a:base)

      let ncmd = "mcpl " . query
      for m in systemlist(ncmd)
        if complete_check()
          break
        endif

        call complete_add(m)
      endfor
      return []
    endif
  endif
endfunction

augroup mblaze_address
  au!
  au FileType mail setlocal completefunc=CompleteAddress
augroup END
