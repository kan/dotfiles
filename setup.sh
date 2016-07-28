ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install ghq peco zsh vim tmux git coreutils boost

GHQ_ROOT=~/src ghq get git@github.com:kan/dotfiles.git

ln -s ~/src/github.com/kan/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/src/github.com/kan/dotfiles/zsh/.zshenv ~/.zshenv
mkdir -p ~/.zsh
ln -s ~/src/github.com/kan/dotfiles/zsh/prompt ~/.zsh/prompt
ln -s ~/src/github.com/kan/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/src/github.com/kan/dotfiles/vim/.vim ~/.vim
ln -s ~/src/github.com/kan/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/src/github.com/kan/dotfiles/git/gitignore ~/.gitignore
ln -s ~/src/github.com/kan/dotfiles/dir_colors ~/.dir_colors
ln -s ~/src/github.com/kan/dotfiles/tmux ~/.tmux.conf

cp ~/src/github.com/kan/dotfiles/zsh/.zshenv.local-mac ~/.zshenv.local

cd ~/src/github.com/kan/dotfiles/
git submodule init
git submodule update

sudo curl -L https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight > /usr/local/bin/diff-highlight
sudo chmod +x /usr/local/bin/diff-highlight

sudo vim /etc/shells
chsh
