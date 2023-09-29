# Global Constants
MHROOT="$HOME/Developer/mhgit"
MMROOT="$HOME/Developer/mmgit"
DEVELOPER="/Volumes/Rendon/RDeveloper"
DOTFILES="$DEVELOPER/mmdotfiles"

# General setup
git clone mmdotfiles $DOTFILES
# install https://ohmyz.sh/
rm $HOME/.zshrc
ln -s $DOTFILES/zshrc.sh $HOME/.zshrc
ln -s $DOTFILES/gitconfig $HOME/.gitconfig
echo "export PATH=\"$HOME/bin:$PATH\"" >> $HOME/.zshenv

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/mherrerarendon/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# vim
brew install neovim
mkdir .vim
ln -s $DOTFILES/vimrc $HOME/.vim/vimrc
mkdir .config
mkdir $HOME/.config/nvim
ln -s $DOTFILES/init.vim $HOME/.config/nvim/init.vim

# vscode
ln -s $HOME/Developer/dotfiles/snippets $HOME/Library/Application\ Support/Code/User/snippets
rm $HOME/Library/Application\ Support/Code/User/settings.json
ln -s $DOTFILES/code.json $HOME/Library/Application\ Support/Code/User/settings.json
# install the `code` command line util in ~/bin

# sublime merge
ln -s /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge /Users/mherrerarendon/bin/smerge
