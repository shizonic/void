#!/usr/bin/env sh

export variant=$(cat variant)
export base00=$(sed -n '1p' "stc/shades.list")
export base01=$(sed -n '2p' "stc/shades.list")
export base02=$(sed -n '3p' "stc/shades.list")
export base03=$(sed -n '4p' "stc/shades.list")
export base04=$(sed -n '5p' "stc/shades.list")
export base05=$(sed -n '6p' "stc/shades.list")
export base06=$(sed -n '7p' "stc/shades.list")
export base07=$(sed -n '8p' "stc/shades.list")

if test "${variant}" = 'light'; then
  export base08=$(sed -n '3p' "colors.list")
  export base09=$(sed -n '4p' "colors.list")
  export base0A=$(sed -n '5p' "colors.list")
  export base0B=$(sed -n '3p' "colors.list")
  export base0C=$(sed -n '4p' "colors.list")
  export base0D=$(sed -n '5p' "colors.list")
  export base0E=$(sed -n '6p' "colors.list")
  export base0F=$(sed -n '8p' "colors.list")
else
  export base08=$(sed -n '5p' "colors.list")
  export base09=$(sed -n '4p' "colors.list")
  export base0A=$(sed -n '3p' "colors.list")
  export base0B=$(sed -n '5p' "colors.list")
  export base0C=$(sed -n '4p' "colors.list")
  export base0D=$(sed -n '3p' "colors.list")
  export base0E=$(sed -n '6p' "colors.list")
  export base0F=$(sed -n '8p' "colors.list")
fi

export wallpaper=$(find -type f -name 'wall.*' | head -1)
export thumbnail=$(find -type f -name 'thumb.*' | head -1)
