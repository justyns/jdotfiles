" Vim 9 ships nginx syntax, but the older boxes (CentOS 7 / vim 7.4) don't
au BufRead,BufNewFile /etc/nginx/*.conf set ft=nginx
au BufRead,BufNewFile /etc/nginx/conf.d/* set ft=nginx
au BufRead,BufNewFile /etc/nginx/sites-*/* set ft=nginx
