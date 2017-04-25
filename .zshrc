export ZSH=/Users/$(whoami)/.oh-my-zsh

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="zsh2200"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

plugins=(zsh-completions zsh-syntax-highlighting zsh-autosuggestions last-working-dir git vagrant osx brew)
autoload -U compinit && compinit

# Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

bindkey '^T' autosuggest-toggle

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#cask
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export ZSH_2000_DEFAULT_USER='CHANGE ME'
export ZSH_2000_DISABLE_RVM='true'
export ZSH_2000_DISABLE_GIT_STATUS='true'
# My theme customizations
# export ZSH_2000_DISABLE_RIGHT_PROMPT='false'
export ZSH_2000_DISABLE_TIME='true'
export ZSH_2000_DISABLE_GIT_TIME='true'
export ZSH_2000_GIT_PROMPT_RIGHT='true'

# Copied from a CentOS box
for i in "~/profile.d/*.sh" ; do
    if [ -r "$i" ]; then
        if [ "${-#*i}" != "$-" ]; then
            . "$i"
        else
            . "$i" >/dev/null 2>&1
        fi
    fi
done
