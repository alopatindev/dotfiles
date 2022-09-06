# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="gentoo"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git autojump command-not-found syntax-highlighting zsh-syntax-highlighting zsh-autosuggestions)
#plugins=(git autojump command-not-found syntax-highlighting zsh-syntax-highlighting)
#plugins=(git autojump command-not-found zsh-syntax-highlighting)
plugins=(git command-not-found zsh-syntax-highlighting)

fpath+=~/.zsh/completions

source $ZSH/oh-my-zsh.sh

autoload -U compinit && compinit

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'
ZSH_AUTOSUGGEST_STRATEGY=match_prev_cmd

# don't kill background processes when exiting zsh
setopt NO_HUP

# Customize to your needs...
# git://github.com/robbyrussell/oh-my-zsh.git

source ~/.bash_env
source ~/.bash_alias

bindkey \^U backward-kill-line
#bindkey \^H backward-kill-word
bindkey '\e[7;5~' backward-kill-word
#bindkey '<ctrl-v><ctrl+left-arrow>' backward-word
#bindkey '<ctrl-v><ctrl+right-arrow>' forward-word

#bindkey -v # vim mode

unsetopt share_history

mkdir -p /tmp/.vimswaps/

#~/.private/sync_vimwiki.sh

## https://superuser.com/questions/585545/how-to-disable-zsh-tab-completion-for-nfs-dirs/586088#586088
#function restricted-expand-or-complete() {
#   # split into shell words also at "=", if IFS is unset use the default (blank, \t, \n, \0)
#   local IFS="${IFS:- \n\t\0}="
#
#   # this word is completed
#   local complt
#
#   # if the cursor is following a blank, you are completing in CWD
#   # the condition would be much nicer, if it's based on IFS
#   if [[ $LBUFFER[-1] = " " || $LBUFFER[-1] = "=" ]]; then
#       complt="$PWD"
#   else
#       # otherwise take the last word of LBUFFER
#       complt=${${=LBUFFER}[-1]}
#   fi
#
#   # determine the physical path, if $complt is not an option (i.e. beginning with "-")
#   [[ $complt[1] = "-" ]] || complt=${complt:A}/
#
#   # activate completion only if the file is on a local filesystem, otherwise produce a beep
#   if [[ ! $complt = /nfs/* && ! $complt = /media/* ]]; then
#       zle expand-or-complete
#   #else
#   #    echo -en "\007"
#   fi
#}
#zle -N restricted-expand-or-complete
#bindkey "^I" restricted-expand-or-complete


# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH="/home/al/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/al/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/al/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/al/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/al/perl5"; export PERL_MM_OPT;

precmd() {
    pwd | grep "${HOME}/work/" >> /dev/null && {
        export RUSTFLAGS='-C link-args=-lzstd -C force-frame-pointers=y'
        export CFLAGS=
        export CXXFLAGS=
        for i in target; do
            export CARGO_TARGET_DIR="${HOME}/tmp/$(pwd | sed 's!/!%!g')/${i}"
            mkdir -p "${CARGO_TARGET_DIR}"

            for service in $(ls --color=never -1 services 2>>/dev/null); do
                mkdir -p "${CARGO_TARGET_DIR}/services/${service}"
                touch "${CARGO_TARGET_DIR}/services/${service}/log.jsonl"
            done

            ln -s "${CARGO_TARGET_DIR}" 2>> /dev/null
            unset CARGO_TARGET_DIR
        done
        export RUST_BACKTRACE=full
        unset -f precmd
    }

    [ -z "${TMUX}" ] || {
        max_window_title_length=15
        window_title=$(basename "${PWD}")
        if [ "${#window_title}" -gt "${max_window_title_length}" ]; then
            window_title=$(echo -n "\u2026${window_title: -${max_window_title_length}}")
        fi
        tmux rename-window "${window_title}" 2&>>/dev/null
    }
}

hostname_color='yellow'
if [[ -z "${SSH_TTY}" ]]; then
    hostname_color='green'
fi
export PS1='%(!.%B%F{red}.%B%F{green}%n)%F{'${hostname_color}'}@%m %F{blue}%(!.%1~.%~) ${vcs_info_msg_0_}%F{blue}%(!.#.$)%k%b%f '
