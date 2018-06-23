#!/usr/bin/env sh

printf '<ul class="nav">\n'
for page in ${pages}; do
  eval "$(cat "${here}/${page}" | md2vars)"
  printf '<li class="nav-item"><a href="%s">%s</a></li>\n' "${page%.md}.html" "${title}"
done
printf '</ul>\n'
