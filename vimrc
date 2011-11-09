set background=dark
colorscheme desert
syntax on
filetype plugin on
filetype indent on

#http://irssi.org/documentation/tips
#Auto update changed date to todates date
autocmd BufWrite *.pl %s/changed     => '.*/\="changed     => '" . strftime("%c") . "',"/e
