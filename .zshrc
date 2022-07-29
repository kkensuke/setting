## zsh-git-prompt ##
source /opt/homebrew/opt/zsh-git-prompt/zshrc.sh


## zsh-completions, zsh-autosuggestions ##
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit
  compinit
fi


## PRONPT with $(git_super_status)
precmd() { precmd() { echo } }
PS1='%F{082}%n%f %F{051}%~%f %# $(git_super_status) '


## Basic ##
# change directory
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cb='cd -'
alias d='cd ~/Desktop'
alias dl="cd ~/Downloads"
alias h='cd ~'
alias /='cd /'
alias github='cd ~/github'
alias gj='cd ~/github/programming/jupyterbook/myjb/myjb'
alias gp='cd ~/github/physics'
alias gq='cd ~/github/physics/qc'
alias senkyo='cd ~/github/senkyo/'
alias s='cd ~/github/programming/setting'
alias class='cd ~/My\ Drive/master/class/'

mkc() { mkdir -p "$@" && cd "$_"; }

# Change working directory to the top-most Finder window location. cdf short for `cdfinder`
cdf() { cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" }

# show files
alias ls='ls -CGF'
alias l='ls'
alias la='l -a'
alias ll='l -ahlS'
alias pwd='pwd | sed "s/ /\\\ /g"'
alias p='pwd'
alias path='echo -e ${PATH//:/\\n}'

# `tr` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tr() { tree -ahC -L "$1" -I '.git' --dirsfirst | less -FRNX; }


# edit files
alias cp='cp -iv'
dp() {cp -r "$1" "$1"_copy}
alias mv='mv -iv'
alias rm='rm -iv'
alias rmf='rm -vf'
alias rmr='rm -ir'
alias rmrf='rm -rvf'

# others
alias b='brew'
alias his='history'
alias grep='grep --color'
alias ner='2>/dev/null'
alias rl="exec ${SHELL} -l" #reload

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# vim
alias v='vi'
alias vz='vi ~/.zshrc'
alias so='source'
alias sz='source ~/.zshrc'

# open apps
alias now='open .'
alias c='open /Applications/CotEditor.app'
alias vs='code'
alias z='s;open /Applications/CotEditor.app .zshrc'
alias opjb='gj;open /Applications/Firefox.app _build/html/index.html'
alias firefox='open /Applications/Firefox.app'
alias chrome='open /Applications/Google\ Chrome.app'
alias safari='open /Applications/Safari.app'


## Mac settings
# Screenshot
alias dwl='defaults write com.apple.screencapture location'
alias ddl='defaults delete com.apple.screencapture location'
alias drl='defaults read com.apple.screencapture location'

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons
alias dhide="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias dshow="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"


## GitHub ##
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gcm='git commit'
alias gcmm='git commit -m'
alias gch='git checkout'
alias gchm='git checkout main'
alias gchms='git checkout master'
alias gcl='git clone'
alias gd='git diff'
alias gf='git fetch'
alias gin='git init'
alias gm='git merge'
alias gpl='git pull'
alias gps='git push'
alias gpo='git push origin'
alias gpom='git push origin main'
alias gs='git status'

# EMOJI-LOG (https://github.com/ahmadawais/Emoji-Log)
# See more in .gitmessage
gacpm() { git add -A && git commit -m "$1" && git push origin main }
gacp() { git add -A && git commit -m "$2" && git push origin "$1" }

gini() { gacpm "🎉 Initial commit"}
gnew() { gacpm "✨ NEW: $1" }
gimp() { gacpm "👌 IMPROVE: $1" }
gprg() { gacpm "🚧 PROGRESS: $1" }

gmtn() { gacpm "🔧 MAINTAIN: $1" }
gfix() { gacpm "🐛 FIX: $1" }
ghot() { gacpm "🚑 HOTFIX: $1" }
gbrk() { gacpm "‼️ BREAKING: $1" }
grem() { gacpm "🗑️ REMOVE: $1" }

gmrg() { gacpm "🔀 MERGE: $1" }
gref() { gacpm "♻️ REFACTOR: $1" }
gtst() { gacpm "🧪 TEST: $1" }
gdoc() { gacpm "📚 DOC: $1" }
grls() { gacpm "🚀 RELEASE: $1" }
gsec() { gacpm "👮 SECURITY: $1" }

# Show commit type
gty() {
NORMAL='\033[0;39m'
GREEN='\033[0;32m'
echo "$GREEN gini$NORMAL — 🎉 Initial commit
$GREEN gnew$NORMAL — ✨ NEW
$GREEN gimp$NORMAL — 👌 IMPROVE
$GREEN gprg$NORMAL — 🚧 PROGRESS
$GREEN gmtn$NORMAL — 🔧 MAINTAIN
$GREEN gfix$NORMAL — 🐛 FIX
$GREEN ghot$NORMAL — 🚑 HOTFIX
$GREEN gbrk$NORMAL — ‼️  BREAKING
$GREEN grem$NORMAL — 🗑️  REMOVE
$GREEN gmrg$NORMAL — 🔀 MERGE
$GREEN gref$NORMAL — ♻️  REFACTOR
$GREEN gtst$NORMAL — 🧪 TEST
$GREEN gdoc$NORMAL — 📚 DOC
$GREEN grls$NORMAL — 🚀 RELEASE
$GREEN gsec$NORMAL — 👮 SECURITY"
}


eval "$(gh completion -s zsh)"

# make a new repository based on the current directory
ginit() {
	git init
	git add .
	git commit -m "🎉 Initial commit"
	gh repo create --private --source=. --push
}

# gitignore.io
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

# make a branch and checkout to it
gcb() { git checkout -b "$1"; git push origin "$1" }
# make changes
# gacp <branch> <comment>
# delete merged local&remote branch
gbd() { gch master; gpl; git branch -d "$1"; git push origin :"$1" }


## Python ##
alias python="/usr/bin/python3"
alias py='python'
alias py2='python2'
alias py3='python3'
alias wpy='which python'

alias pip='pip3'
alias pin='pip install'
alias pup='pip install --upgrade pip'
alias pinreq='pip install -r requirements.txt'
alias pf='pip list --format=freeze'
alias pfr='pip list --format=freeze > requirements.txt'

# venv
alias mkv='python3 -m venv venv; acv; pip install --upgrade pip'
alias acbase='source ~/base/bin/activate'
alias aq='source ~/github/physics/qc/quantum-computation-ref/venv/bin/activate'
alias acv='source venv/bin/activate'
alias deac='deactivate'

# jupyterbook
alias jl='jupyter-lab'

# build and publish jupyter-book
jbg(){
	cd ~/github/programming/jupyterbook/$1
	acv
	cd ~/github/programming/jupyterbook/$1/$1
	jb build --all .
	gacpm add
	ghp-import -n -p -f _build/html
}

# alias ghp='ghp-import -n -p -f _build/html'


## Latex ##
# make latex template directory
mklt(){
	cp -r ~/.latex-template ./$1
}

## ref: https://github.com/mathiasbynens/dotfiles/blob/main