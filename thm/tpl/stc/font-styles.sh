#!/usr/bin/env sh

if test -f 'fonts.list'; then
  norm=$(sed '1q;d' 'fonts.list')
  mono=$(sed '2q;d' 'fonts.list')
  symb=$(sed '3q;d' 'fonts.list')
  export fontName="$(echo "${norm}" | cut -d ':' -f 1)"
  export fontSize="$(echo "${norm}" | cut -d ':' -f 2)"
  export monoName="$(echo "${mono}" | cut -d ':' -f 1)"
  export monoSize="$(echo "${mono}" | cut -d ':' -f 2)"
  export symbName="$(echo "${symb}" | cut -d ':' -f 1)"
  export symbSize="$(echo "${symb}" | cut -d ':' -f 2)"
else
  export fontName='Ubuntu'
  export fontSize='12'
  export monoName='Ubuntu Mono'
  export monoSize='12'
  export symbName='Font Awesome 5 Free'
  export symbSize='12'
fi
