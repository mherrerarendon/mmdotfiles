#!/bin/bash

# make sure GITROOT env variable is setup

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

snippets() {
    nvim $HOME/Developer/dotfiles/snippets/$1.json
}

findrepo() {
    mdfind kind:folder $1 -onlyin .
}

ingh() {
    repo_url=`git config --get remote.origin.url`
    echo Launching $repo_url
    open $repo_url
}

ghcompare() {
    branch=`git rev-parse --abbrev-ref HEAD`
    repo_url=`git config --get remote.origin.url`
    default_branch=`git remote show origin | sed -n '/HEAD branch/s/.*: //p'`
    echo Launching $repo_url
    open $repo_url/compare/$default_branch...$branch
}

getsat() {
    curl --request POST \
--url 'https://sat-stg.codebig2.net/v2/oauth/token' \
--header 'Content-Type: application/json' \
--header 'X-Client-Id: cvo' \
--header 'X-Client-Secret: 35e0379e904b6ecd4d40ded1cf3b5a14'
}

scpcvo() {
    scp -i ~/.ssh/cvo-dev.pem $1 ubuntu@$CVODEV:/home/ubuntu
}

scpfromcvo() {
    scp -i ~/.ssh/cvo-dev.pem ubuntu@$CVODEV:$1 $2
}

scpcvo-1() {
    scp -i ~/.ssh/ashburn-cvo $1 admin@96.99.199.81:/home/admin
}

getmpd() {
    curl $1 | xmllint --format -
}

livelog() {
    kubectl logs -f $1
}

clotcpdump() {
    kubectl exec -it $1 -- sh -c 'tcpdump -i eth0 -w - src host $2 and dst host `hostname -i` and dst port 3000' > ./clo-dump.pcap
}

cvo_podman() {
    podman machine init
    podman machine start
}

scte35() {
    python $GITROOT/comcast/tools/scripts/scte35/scte35.py $1
}

cargoclean() {
    TARGET_FILE="Cargo.toml"
    COMMAND='cargo clean'

    find . -type d | while read dir; do
	if [ -e "$dir/$TARGET_FILE" ]; then
	    (
	        cd "$dir" || exit 1
		echo "Cleaning $dir..."
	        eval "$COMMAND"
    	    )
	fi
    done
}

# Aliases
alias hosts="sudo nvim /private/etc/hosts"
alias sshconfig="nvim ~/.ssh/config"
alias paths="sudo nvim /etc/paths"
alias refresh="source ~/.zshrc && source ~/.zshenv"
alias aliasconfig="nvim $GITROOT/dotfiles/alias.sh"
alias gconfig="nvim .git/config"
alias gitignore="nvim .gitignore"
alias cpwd="pwd | pbcopy"
alias awsconfig="nvim ~/.aws/config"
alias awscreds="nvim ~/.aws/credentials"
alias sshcvo="ssh -i ~/.ssh/cvo-dev.pem ubuntu@$CVODEV"
alias cvometrics="curl -k https://$CVODEV:3000/metrics"
alias cvo1metrics="curl -k https://$CVO1:3000/metrics"
alias cvo2metrics="curl -k https://$CVO2:3000/metrics"
alias startgrafana="brew services start grafana"
alias stopgrafana="brew services stop grafana"
alias jumpk="jump -k ~/.ssh/ashburn-cvo$@"
alias jumpcvo1="jump -k ~/.ssh/ashburn-cvo admin@$CVO1"
alias jumpcvo2="jump -k ~/.ssh/ashburn-cvo admin@$CVO2"
alias sshcvo1="ssh -i ~/.ssh/ashburn-cvo admin@$CVO1"
alias cvopsql="psql postgres"
alias dockerpsql="docker exec -it postgres psql -U postgres"
alias smergeclo="smerge $GITROOT/clo && smerge $GITROOT/clo2 && smerge $GITROOT/clo3"
alias codeclo="code $GITROOT/clo && code $GITROOT/clo2 && code $GITROOT/clo3"
alias zedclo="zed $GITROOT/clo && zed $GITROOT/clo2 && zed $GITROOT/clo3"

# copy x5c value to clipboard and then run this command
alias dumpcert="pbpaste | base64 -d | openssl x509 -text -noout"

# cd shortcuts
alias cdgit="cd $GITROOT"
alias cddotfiles="cd $DOTFILES"
alias cddesktop="cd ~/Desktop"
alias cdlima="cd /tmp/lima/cvo && lima"

# linked dotfiles
alias gitconfig="nvim ~/.gitconfig"
alias codeconfig="nvim ~/Library/Application\ Support/Code/User/settings.json"
alias zconfig="nvim ~/.zshrc"
alias vimconfig="nvim ~/.vim/vimrc"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias envconfig="nvim ~/.zshenv"
