#!/bin/bash

# Global Constants
MHROOT="$HOME/Developer/mhgit"
MMROOT="$HOME/Developer/mmgit"
MAROOT="$MMROOT/ma"
MAWWW="$MAROOT/www"

# Functions
flutter_poc() {
    cd $MMROOT/ma/flutter_poc
    smerge .
    code .
}

aria() {
    cd $MMROOT/Aria2021
    code .
    smerge .
    open Garritan/Sampler/SmplLib/mac/ARIA_xc12.xcodeproj
    open Garritan/Sampler/LogGetter/workspace/mac/LogGetter.xcodeproj
}

soundtest() {
    cd $MHROOT/flutter/sound_test
    code .
    smerge .
    open ios/Runner.xcworkspace
}

mmclone() {
    repo_url=${1/github.com/github-mm}
    git clone $repo_url
}

mhclone() {
    repo_url=${1/github.com/github-mh}
    git clone $repo_url
}

masetup() {
    cd $MAROOT
    smerge music-architect
    smerge SolFramework
    code music-architect
    code SolFramework
}

sol() {
    cd $MAROOT/SolFramework
    smerge .
    code .
    open "Solide Project/MacProject/Solide M1.xcodeproj"
}

citools() {
    cd $MMROOT/FinaleCITools
    smerge .
    code .
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

mnxsetup() {
    cd $MHROOT
    cd rust_notation
    smerge mnx-edit
    smerge mnx-layout
    smerge mnx-rs
    code mnx-edit
    code mnx-layout
    ls
}

fnf() {
    python ~/FinaleAutomation/support/FileUpdaters/CreateFnfs.py "$1"
}

fixssh() {
    ssh-add ~/.ssh/id_mh
    ssh-add ~/.ssh/id_mm_pw
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

sharing() {
    cd $MMROOT/Finale$1
    open MusicSharing/MusicSharingMac/MusicSharingMac.xcodeproj
    code .
    smerge .
}

fin() {
    cd $MMROOT/Finale$1
    open FinaleMacProject/Finale/Finale.xcworkspace
    code .
    smerge .
}

finsmerge() {
    smerge 2012FileConverter
    smerge FinaleLib/LIB
    smerge PlogueEngine
}
cdfin() {
    cd $MMROOT/Finale$1
}

cdplugins() {
    cd $MMROOT/Plugins$1/FinExt
}

fa() {
    cd ~/FinaleAutomation
    smerge .
    code .
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
alias refresh="source ~/.zshrc"
alias aliasconfig="nvim ~/Developer/dotfiles/alias.sh"
alias gconfig="nvim .git/config"
alias gitignore="nvim .gitignore"
alias cpwd="pwd | pbcopy"
alias macode="code $MAROOT/SmartMusicCompose/"
alias madebug="open http://localhost:8080/SmartMusicCompose/SmartMusicCompose.html"
alias solide="open /Applications/solide"

# cd shortcuts
alias cdmmgit="cd $MMROOT"
alias cdmhgit="cd $MHROOT"
alias cddotfiles="cd ~/Developer/dotfiles"
alias cdma="cd $MMROOT/ma"
alias desktop="cd ~/Desktop"

# linked dotfiles
alias gitconfig="nvim ~/.gitconfig"
alias codeconfig="nvim ~/Library/Application\ Support/Code/User/settings.json"
alias zconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vim/vimrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
