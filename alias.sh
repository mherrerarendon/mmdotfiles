#!/bin/bash

# Global Constants
MHROOT="/Volumes/Rendon/RDeveloper"
MMROOT="$HOME/Developer/mmgit"
MAROOT="$MMROOT/mm/ma"
MAWWW="$MAROOT/www"
FINALE_ECO="$MMROOT/finale"

# Setup functions
mnx() {
    cd $MMROOT
    smerge mnx-rs
    code mnx-rs
    ls
}

ma() {
    cd $MAROOT/music-architect
    smerge .
    code .
    open "Project - NonRegressionTest/MacProject/Project M1.xcodeproj"
}

sol() {
    cd $MAROOT/SolFramework
    smerge .
    code .
    open "Solide Project/MacProject/Solide M1.xcodeproj"
}

citools() {
    cd $FINALE_ECO/FinaleCITools
    smerge .
    code .
}

fin() {
    cd $FINALE_ECO/Finale$1
    open FinaleMacProject/Finale/Finale.xcworkspace
    code .
    smerge .
}

sharing() {
    cd $FINALE_ECO/Finale$1
    open MusicSharing/MusicSharingMac/MusicSharingMac.xcodeproj
    code .
    smerge .
}

fa() {
    cd ~/FinaleAutomation
    smerge .
    code .
}

# Functions
build_sol() {
    python3 $MAROOT/SolFramework/Scripts/build.py --ide
}

matest() {
    OUTPUT=$(xcrun xcodebuild \
	-scheme NonRegressionMATest \
	-project "$MAROOT/music-architect/Project - NonRegressionTest/MacProject/Project M1.xcodeproj" \
	-configuration Debug)
    if [[ $? == 0 ]]; then
	open $MAROOT/music-architect/Project\ -\ NonRegressionTest/MacProject/build/Debug/NonRegressionMATest.app
    fi
}

fnf() {
    python ~/FinaleAutomation/support/FileUpdaters/CreateFnfs.py "$1"
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
    rm ~/Library/Preferences/com.makemusic.Finale27.plist
    rm ~/Library/Preferences/com.makemusic.finale27.fprf
}

finsmerge() {
    smerge 2012FileConverter
    smerge FinaleLib/LIB
    smerge PlogueEngine
}

cdfin() {
    cd $FINALE_ECO/Finale$1
}

cdplugins() {
    cd $FINALE_ECO/Plugins$1/FinExt
}

mmgo() {
    repoPath=$(python $MMROOT/tools/go_to_repo.py $1)
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
    echo "def dummy():\n\tpass" | tee -a src/__init__.py >/dev/null
    mkdir tests
    touch tests/__init__.py
    touch tests/test_src.py
    echo "import src\ndef test_src():\n\tsrc.dummy()\n\tassert 1 == 1" | tee -a tests/test_src.py >/dev/null
    python3 -m venv venv
    source venv/bin/activate
    touch requirements.txt
}

maserver() {
    cd "$MAWWW"
    http-server
}

getsol() {
    aws s3 cp s3://mm-build-shelf/builds/components/SolFramework/compiler/stable/mac/SolCompiler1.1.180.zip ~/bin/SolCompiler.zip
    (cd ~/bin && tar -xf SolCompiler.zip)
    rm ~/bin/SolCompiler.zip
    mv -f ~/bin/SolCompiler/SolideCL ~/bin
    rm -rf ~/bin/SolCompiler
}

snippets() {
    nvim $HOME/Developer/dotfiles/snippets/$1.json
}

startauth() {
    cd $MMROOT/composeui/auth
    ./bin/setup
}

findrepo() {
    mdfind kind:folder $1 -onlyin .
}

ingh() {
    repo_url=`git config --get remote.origin.url`
    echo Launching $repo_url
    open $repo_url
}

infinder() {
    open .
}

ghdeploy() {
    repo_url=`git config --get remote.origin.url`
    echo Launching $repo_url
    open $repo_url/compare/main...uat
}

ghcompare() {
    branch=`git rev-parse --abbrev-ref HEAD`
    repo_url=`git config --get remote.origin.url`
    default_branch=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    echo Launching $repo_url
    open $repo_url/compare/$default_branch...$branch
}

buildme() {
    branch=`git rev-parse --abbrev-ref HEAD`
    url=https://$branch.uat.makemusic.com
    echo Launching $url
    open $url
}

localdev() {
    url=http://srstudio.makemusic.localhost:4208/
    echo Launching $url
    open $url
}


# Aliases
alias summary="python $MMROOT/tools/summary.py"
alias mmlist="python $MMROOT/tools/list_repos.py"
alias getfin="python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a app"
alias getmacinstall="python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -r"
alias getwininstall="python ~/FinaleAutomation/Download_Finale_Clean_Install.py -a installer -r -o win32"
alias hosts="sudo nvim /private/etc/hosts"
alias sshconfig="nvim ~/.ssh/config"
alias applyrules="sudo pfctl -a com.apple.internet-sharing/shared_v4 -N -f ~/Documents/newrules.conf 2>/dev/null"
alias rules="sudo pfctl -a com.apple.internet-sharing/shared_v4 -s nat 2>/dev/null"
alias paths="sudo nvim /etc/paths"
alias refresh="source ~/.zshrc && source ~/.zshenv"
alias aliasconfig="nvim ~/Developer/mmdotfiles/alias.sh"
alias gconfig="nvim .git/config"
alias gitignore="nvim .gitignore"
alias cpwd="pwd | pbcopy"
alias macode="code $MAROOT/SmartMusicCompose/"
alias madebug="open http://localhost:8080/SmartMusicCompose/SmartMusicCompose.html"
alias solide="open /Applications/solide"
alias finuat="open /Applications/Finale.app --args -d \"UATSharing=true\""
alias parisak="sh ~/Developer/parisak.sh"
alias awsconfig="nvim ~/.aws/config"
alias awscreds="nvim ~/.aws/credentials"
alias rubyconfig="nvim ~/.bundle/config"

# cd shortcuts
alias cdmmgit="cd $MMROOT"
alias cdmhgit="cd $MHROOT"
alias cddotfiles="cd ~/Developer/mmdotfiles"
alias cdma="cd $MMROOT/ma"
alias cdmarch="cd $MMROOT/march"
alias cdsol="cd $MMROOT/ma/SolFramework"
alias cddesktop="cd ~/Desktop"
alias cdcompose="cd $MMROOT/composeui"
alias cdredux="cd $MMROOT/composeui/with_redux"
alias cdfa="cd $HOME/FinaleAutomation"

# linked dotfiles
alias gitconfig="nvim ~/.gitconfig"
alias codeconfig="nvim ~/Library/Application\ Support/Code/User/settings.json"
alias zconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vim/vimrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias envconfig="nvim ~/.zshenv"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
