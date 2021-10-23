# Functions
fnf() {
    python /Users/mherrerarendon/FinaleAutomation/support/FileUpdaters/CreateFnfs.py "$1"
}

qmlscene() {
    /Users/mherrerarendon/Qt/5.12.1/clang_64/bin/qmlscene "$1"
}

fixssh() {
    ssh-add ~/.ssh/id_mh
    ssh-add ~/.ssh/id_mm
}

musx() {
    python /Users/mherrerarendon/FinaleAutomation/support/FileUpdaters/CreateMusx.py "$1"
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
    python /Users/mherrerarendon/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -l "$1" -r
}

getwininstalllang() {
    python /Users/mherrerarendon/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -l "$1" -r -o win32
}

getfinlang() {
    python /Users/mherrerarendon/FinaleAutomation/Download_Finale_Clean_Install.py -a app -l "$1"
}

clearfinprefs() {
    rm ~/Library/Preferences/com.makemusic.Finale26.plist
    rm ~/Library/Preferences/com.makemusic.finale26.fprf
}

cdfin() {
    cd /Users/mherrerarendon/Developer/mmgit/Finale$1
}

cdplugins() {
    cd /Users/mherrerarendon/Developer/mmgit/Plugins$1/FinExt
}

cdfa() {
    cd /Users/mherrerarendon/FinaleAutomation
    python setup.py
}

mmgo() {
    repoPath=$(python /Users/mherrerarendon/Developer/mmgit/tools/go_to_repo.py $1)
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
alias summary="python /Users/mherrerarendon/Developer/mmgit/tools/summary.py"
alias mmlist="python /Users/mherrerarendon/Developer/mmgit/tools/list_repos.py"
alias getfin="python /Users/mherrerarendon/FinaleAutomation/Download_Finale_Clean_Install.py -a app"
alias getmacinstall="python /Users/mherrerarendon/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -r"
alias getwininstall="python /Users/mherrerarendon/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -r -o win32"
alias hosts="sudo nvim /private/etc/hosts"
alias sshconfig="nvim /Users/mherrerarendon/.ssh/config"
alias applyrules="sudo pfctl -a com.apple.internet-sharing/shared_v4 -N -f ~/LocalDesktop/newrules.conf 2>/dev/null"
alias rules="sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat 2>/dev/null"
alias paths="sudo nvim /etc/paths"
alias refresh="source ~/.zshrc"
alias aliasconfig="nvim ~/Developer/dotfiles/alias.sh"

# cd shortcuts
alias cdmmgit="cd /Users/mherrerarendon/Developer/mmgit"
alias cdmhgit="cd /Users/mherrerarendon/Developer/mhgit"
alias cdrust="cd /Users/mherrerarendon/Developer/mhgit/rust"
alias cddotfiles="cd /Users/mherrerarendon/Developer/dotfiles"

# linked dotfiles
alias gitconfig="nvim ~/.gitconfig"
alias codeconfig="nvim ~/Library/Application\ Support/Code/User/settings.json"
alias zconfig="nvim ~/.zshrc"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
