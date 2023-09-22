# Global Constants
MHROOT="$HOME/Developer/mhgit"
MMROOT="$HOME/Developer/mmgit"

# General setup
git clone mmdotfiles ~/Developer/mmdotfiles
# install https://ohmyz.sh/
rm .zshrc
ln -s /Users/mherrerarendon/Developer/mmdotfiles/zshrc.sh ~/.zshrc
ln -s /Users/mherrerarendon/Developer/mmdotfiles/gitconfig ./.gitconfig
echo "export PATH=\"$HOME/bin:$PATH\"" >> ~/.zshenv

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/mherrerarendon/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# vim
brew install neovim
mkdir .vim
ln -s /Users/mherrerarendon/Developer/mmdotfiles/vimrc ~/.vim/vimrc
mkdir .config
mkdir ~/.config/nvim
ln -s /Users/mherrerarendon/Developer/mmdotfiles/init.vim ~/.config/nvim/init.vim

# vscode
ln -s $HOME/Developer/dotfiles/snippets $HOME/Library/Application\ Support/Code/User/snippets
rm ~/Library/Application\ Support/Code/User/settings.json
ln -s /Users/mherrerarendon/Developer/mmdotfiles/code.json ~/Library/Application\ Support/Code/User/settings.json
# install the `code` command line util in ~/bin

# sublime merge
ln -s /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge /Users/mherrerarendon/bin/smerge
