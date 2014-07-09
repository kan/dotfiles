export PATH=/usr/local/bin:$PATH
if [ -e ~/.zshenv.local ]; then
  source ~/.zshenv.local
fi
eval $(dircolors -b ~/.dir_colors)
