ln -s ~/src/github.com/kan/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/src/github.com/kan/dotfiles/zsh/.zshenv ~/.zshenv
ln -s ~/src/github.com/kan/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/src/github.com/kan/dotfiles/vim/.vim ~/.vim
ln -s ~/src/github.com/kan/dotfiles/screen/.screenrc ~/.screenrc
ln -s ~/src/github.com/kan/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/src/github.com/kan/dotfiles/git/gitignore ~/.gitignore
ln -s ~/src/github.com/kan/dotfiles/dir_colors ~/.dir_colors
ln -s ~/src/github.com/kan/dotfiles/tmux ~/.tmux.conf
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git submodule init
git submodule update
