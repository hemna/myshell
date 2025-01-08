# Based off of https://github.com/robbyrussell/oh-my-zsh
# First instatll oh-my-zsh
# sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
if [[ `uname` == 'Linux' ]]
then
  export ZSH=~/.oh-my-zsh
  export DOTFILES=~/.dotfiles
fi

if [[ `uname` == 'Darwin' ]]
then
  export ZSH=$HOME/.oh-my-zsh
  export DOTFILES=$HOME/.dotfiles
fi

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#
# To install this theme
# git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
my_themes=(
    "powerlevel9k/powerlevel9k" "xiong-chiamiov-plus" "gnzh" "ys"
    "takashiyoshida" "suvash"
    "strug" "steeef" "smt" "simonoff" "rkj" "rkj-repos"
    "rgm" "pygmalion" "mortalscumbag" "linuxonly"
    )
maybe=(
    "jnrow" "jreese" "kennethreitz" "maran" "minimal"
    "muse" "nanotech" "norm" "negirhos" "superjarin"
    )
#ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="xiong-chiamiov-plus"
# pick a random theme from the bitches I like.
#ZSH_THEME="xiong-chiamiov-plus"
if [[ -s ~/.oh-my-zsh/themes/walt-fino.zsh-theme ]]; then
  #ZSH_THEME="walt-sap"
  ZSH_THEME="walt-fino"
else
  #ZSH_THEME="xiong-chiamiov-plus"
  ZSH_THEME="fino"
fi

#ZSH_THEME="random"
ZSH_THEME_RANDOM_CANDIDATES=($my_themes)
#(
#    "powerlevel9k/powerlevel9k" "xiong-chiamiov-plus" "gnzh" "ys"
#    "takashiyoshida" "suvash"
#    "strug" "steeef" "smt" "simonoff" "rkj" "rkj-repos"
#    "rgm" "pygmalion" "mortalscumbag" "linuxonly"
#    )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    autojump
    autopep8
#    battery
    bgnotify
#    catimg
    command-not-found
    colorize
#    colored-man-pages
#    docker
    extract
#    git
    git-extras
#    jsontools
#    python
    screen
    sudo
#    thefuck
    tig
    transfer
#    vagrant
    vi-mode
#    virtualenv
#   z
)

source $ZSH/oh-my-zsh.sh
source $DOTFILES/dotfiles.sh

# User configuration
#
ZSH_COLORIZE_STYLE="colorful"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history battery time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator ssh command_execution_time background_jobs battery time)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#
#
# enable bash-completion compatibility
autoload bashcompinit
bashcompinit

export VAGRANT_DEFAULT_PROVIDER=libvirt

if [ -e ~/.dotfiles/lib/core.sh ]; then
    source ~/.dotfiles/lib/core.sh
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
#
source ~/.aliases
if [ -e ~/.dotfiles/.aliases_zsh ]; then
    source ~/.dotfiles/.aliases_zsh
fi

# add anything in the ~/.bin to the path
export PATH=$PATH:~/.bin:/sbin:~/.local/bin

# Add any local settings that aren't in .dotfiles
if [[ -s ~/.local.zsh ]]; then
    source ~/.local.zsh
fi
# echo "Loading ~/.local.zsh done"

if [[ -s ~/.bin/tab_color.py ]]; then
    ~/.bin/tab_color.py
fi

# Disable correctall for cp
alias cp='nocorrect cp '
alias mv='nocorrect mv '
alias mkdir='nocorrect mkdir '

# Disable sharing of history between shells
unsetopt share_history
setopt extendedhistory
setopt histignoredups

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
# Load pyenv into the shell by adding
# the following to ~/.zshrc:
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

export COMP_WORDBREAKS=${COMP_WORDBREAKS/:/}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$PATH:/Users/i530566/.local/bin:$HOME/.cargo/bin:/usr/local/opt/openssl@1.1/bin:/usr/local/opt/sqlite/bin:$PATH"
export EDITOR=vim

eval $(thefuck --alias)

# for python poetry support 
export PATH="$HOME/.poetry/bin:$PATH"

if [[ -s ~/devel/mine/hamradio/aprsd/.aprsd-venv ]]; then
  # source ~/devel/mine/hamradio/aprsd/.aprsd-venv/bin/activate
  eval "$(~/devel/mine/hamradio/aprsd/.aprsd-venv/bin/aprsd completion zsh)"
fi


# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.dotfiles/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}


if [ -e ~/.local-direnv.zsh ]; then
    source ~/.local-direnv.zsh
fi


# ----- Bat (better cat) -----

export BAT_THEME=OneHalfLight

# echo "done loading .zshrc"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"

# zoxide for 'smarter cd'
eval "$(zoxide init zsh)"

. "$HOME/.cargo/env"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/I530566/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/I530566/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/I530566/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/I530566/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$(brew --prefix openssl@3)/bin:$PATH"
