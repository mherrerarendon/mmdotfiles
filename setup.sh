# Prerequisites:
# 1. Setup `DOTFILES` environment variable to the root of the https://github.com/mherrerarendon/mmdotfiles cloned repo
# 2. Setup `GITROOT` environment variable to the folder containing your git repos

# General setup
git clone mmdotfiles $DOTFILES
# install https://ohmyz.sh/
rm $HOME/.zshrc
ln -s $DOTFILES/zshrc.sh $HOME/.zshrc
rm $HOME/.gitconfig
ln -s $DOTFILES/gitconfig $HOME/.gitconfig
echo "export PATH=\"$HOME/bin:$PATH\"" >> $HOME/.zshenv

# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# vim
brew install neovim
mkdir -p .vim
rm $HOME/.vim/vimrc
ln -s $DOTFILES/vimrc $HOME/.vim/vimrc
mkdir .config
mkdir $HOME/.config/nvim
rm $HOME/.config/nvim/init.vim
ln -s $DOTFILES/init.vim $HOME/.config/nvim/init.vim

# vscode
ln -s $DOTFILES/snippets $HOME/Library/Application\ Support/Code/User/snippets
rm $HOME/Library/Application\ Support/Code/User/settings.json
ln -s "$DOTFILES/code.json" "$HOME/Library/Application Support/Code/User/settings.json"
# install the `code` command line util in ~/bin

# sublime merge
ln -s /Applications/Sublime\ Merge.app/Contents/SharedSupport/bin/smerge $HOME/bin/smerge

# zed
ZED_CONFIG="$HOME/.config/zed"
rm $ZED_CONFIG/keymap.json
ln -s $DOTFILES/zed/keymap.json $ZED_CONFIG/keymap.json
rm $ZED_CONFIG/settings.json
ln -s $DOTFILES/zed/settings.json $ZED_CONFIG/settings.json
