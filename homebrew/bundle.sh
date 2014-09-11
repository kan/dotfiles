# update homebrew repos
brew update

# upgrade installed packages
brew upgrade

# add repos
brew tap caskroom/cask 
brew tap homebrew/binary 
brew tap kan/cask

# package for dev
brew install git 
brew install lv 
brew install perl-build 
brew install plenv 
brew install the_silver_searcher 
brew install tmux 
brew install vim 
brew install zsh 


# package for cask
brew install brew-cask 

brew cask update

# brew cask upgrade http://qiita.com/2k0ri/items/9fe8d33a72dbfb15fe6b
for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || brew cask install $c; done

brew cask install karabiner 
brew cask install google-chrome 
brew cask install dropbox 
brew cask install skype 
brew cask install hipchat 
brew cask install iterm2 
brew cask install yorufukurou 
brew cask install limechat 
brew cask install macuim

# remove outdated versions
brew cleanup

brew cask cleanup
