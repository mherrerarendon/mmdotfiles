# Functions
fnf() {
    python ~/FinaleAutomation/support/FileUpdaters/CreateFnfs.py "$1"
}

qmlscene() {
    ~/Qt/5.12.1/clang_64/bin/qmlscene "$1"
}

fixssh() {
    ssh-add ~/.ssh/id_mh
    ssh-add ~/.ssh/id_mm
}

musx() {
    python ~/FinaleAutomation/support/FileUpdaters/CreateMusx.py "$1"
}

getesinstallers() {
    getmacinstalllang es
    getwininstalllang es
}

getinstallers() {
    getmacinstalllang en
    getwininstalllang en
}

getmacinstalllang() {
    python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -l "$1" -r
}

getwininstalllang() {
    python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -l "$1" -r -o win32
}

getfinlang() {
    python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a app -l "$1"
}

clearfinprefs() {
    rm ~/Library/Preferences/com.makemusic.Finale26.plist
    rm ~/Library/Preferences/com.makemusic.finale26.fprf
}

cdfin() {
    cd ~/Developer/mmgit/Finale$1
}

cdplugins() {
    cd ~/Developer/mmgit/Plugins$1/FinExt
}

cdfa() {
    cd ~/FinaleAutomation
    python setup.py
}

mmgo() {
    repoPath=$(python ~/Developer/mmgit/tools/go_to_repo.py $1)
    printf %"s\n"
    echo "New working directory: $repoPath"
    cd $repoPath
}

mxl() {
if [ -d $1/Contents/PlugIns/MusicXML.bundle ]; then
    rm -rf $1/Contents/PlugIns/MusicXML.bundle
    else echo "MusicXML bundle not found"
fi
    cp -r /Applications/Finale.app/Contents/PlugIns/MusicXML.bundle $1/Contents/PlugIns/
    echo "Copied MusicXML.bundle to $1/Contents/PlugIns/"
}

pyinit() {
    mkdir "$1"
    cd "$1"
    mkdir src
    touch src/__init__.py
    python3 -m venv venv
    source venv/bin/activate
}

# Aliases
alias summary="python ~/Developer/mmgit/tools/summary.py"
alias mmlist="python ~/Developer/mmgit/tools/list_repos.py"
alias getfin="python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a app"
alias getmacinstall="python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -r"
alias getwininstall="python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -r -o win32"
alias hosts="sudo nvim /private/etc/hosts"
alias sshconfig="nvim ~/.ssh/config"
alias applyrules="sudo pfctl -a com.apple.internet-sharing/shared_v4 -N -f ~/LocalDesktop/newrules.conf 2>/dev/null"
alias rules="sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat 2>/dev/null"
alias paths="sudo nvim /etc/paths"
alias refresh="source ~/.zshrc"
alias aliasconfig="nvim ~/Developer/dotfiles/alias.sh"
alias gconfig="nvim .git/config"
alias cpwd="pwd | pbcopy"

# cd shortcuts
alias cdmmgit="cd ~/Developer/mmgit"
alias cdmhgit="cd ~/Developer/mhgit"
alias cdrust="cd ~/Developer/mhgit/rust"
alias cddotfiles="cd ~/Developer/dotfiles"

# linked dotfiles
alias gitconfig="nvim ~/.gitconfig"
alias codeconfig="nvim ~/Library/Application\ Support/Code/User/settings.json"
alias zconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vim/vimrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
