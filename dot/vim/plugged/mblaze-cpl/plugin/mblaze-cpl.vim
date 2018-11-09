" Map <tab>
inoremap <tab> <c-r>=CompleteAddress()<cr>
"inoremap <tab> <c-r>=AddressCompletion()<cr>

" Where to look for addresses
let s:addresses = '~/.mblaze/address'

" Function to snag the current string under the cursor
function! SnagString( line )

	" Set column number
	let column =	col('.')-1

	" Split up line		line	start	end
	let begining = strpart(	a:line,	0, 	column)

	" Setup string		source		regex
	let string = matchstr(	begining,	'\S*$')

	return string
endfunction

function FindAddress(string)
  return systemlist('mcpl '. escape(a:string,'\\'))
endfunction

" Function to match a string to an email address
function! MatchAddress(string)
	" Behold, the power unix!
  "let size = system('grep -i '. escape(a:string,'\\'). ' '. s:addresses. ' | sort | uniq | wc -l | xargs')
	let size = system('mcpl '. escape(a:string,'\\'). ' | wc -l')

  if size == 1
		" We have an exact match!
    let address = system('mcpl '. escape(a:string,'\\'))

		return address
	endif
endfunction

function! AddressCompletion()
  let line = getline(line('.'))
  if line =~ '^\(To\|Cc\|Bcc\|From\|Reply-To\):'
    let str = SnagString(line)
    let strlen = strlen(str)
    if strlen > 0
      for m in FindAddress(str)
        if complete_check()
          break
        endif
        call complete_add(m)
      endfor
    endif
  endif
endfunction

" Function <tab> is mapped to
function! CompleteAddress()
	" Fetch current line
	let line = getline(line('.'))

	" Is it a special line?
	if line =~ '^\(To\|Cc\|Bcc\|From\|Reply-To\):'

		" Fetch current string under cursor
		let string = SnagString( line )
		let string_length = strlen(string)
		if string_length > 0

			" Try and match that string to an address
			let address = MatchAddress( string )
			let address_length = strlen( address )
			if address_length > 0 && string_length != address_length

				" Hot dang, we've done and got ourselves a match!
				let paste = strpart( address, string_length, address_length )
				" Convert to lower, remove trailing \n, return
				return substitute(tolower(paste),"\n","","g")
			else

				" No address matched
				return ''
			endif
		else

			" No string found, nothing to compare
			return ''
		endif
	else

		" Not an address line, return a tab
		return "\t"
	endif
endfunction

"augroup mblaze_address
"    au!
"    au FileType mail setlocal completefunc=AddressCompletion
"augroup END
