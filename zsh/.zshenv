if [ -e 'brew' ] ; then
  PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi
eval $(dircolors -b ~/.dir_colors)
if [ -e ~/.zshenv.local ]; then
  source ~/.zshenv.local
fi
