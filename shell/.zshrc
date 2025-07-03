# history {{{
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
# }}}

# export {{{
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZSH_TMUX_AUTOSTART="true"
export ZSH_TMUX_DEFAULT_SESSION_NAME="main"

export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export HOMEBREW_NO_ANALYTICS=1

export TLDR_AUTO_UPDATE_DISABLED=1

if [ -n "$NVIM" ]; then
    export VISUAL="nvr -cc split --remote-wait +'setlocal bufhidden=wipe'"
else
    export VISUAL="nvim"
fi
export MANPAGER="$VISUAL +Man! -"

[[ ! -d ~/bin ]] || export PATH="$HOME/bin:$PATH"
[[ ! -d ~/go ]] || export PATH="$HOME/go/bin:$PATH"
[[ ! -d ~/.cargo/bin ]] || export PATH="$HOME/.cargo/bin:$PATH"

if [[ $(hostname) == *"amazon.com" ]]; then
    # Builder toolbox
    [[ ! -d ~/.toolbox/bin ]] || export PATH=$PATH:$HOME/.toolbox/bin
    # JDK
    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home
    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/
    # export JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto.x86_64
    export JAVA_HOME=/home/linuxbrew/.linuxbrew/opt/openjdk@17/
    # RDE
    # fpath=(~/.zsh/completion $fpath)
    # autoload -Uz compinit && compinit -i
    # envImprovement
    [[ ! -d /apollo/env/envImprovement/bin ]] || export PATH="$PATH:/apollo/env/envImprovement/bin"
fi

typeset -U PATH # remove duplicated entries in $PATH
# }}}


# Oh My ZSH {{{
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git z fzf tmux docker kubectl)
source $ZSH/oh-my-zsh.sh
# }}}


# keybind {{{
bindkey '^[h' backward-kill-word
# }}}


# alias {{{
alias v=$VISUAL
alias www="python3 -m http.server"
alias tm='tmux new -As main'
alias lc=leetcode

if [[ $(hostname) == *"amazon.com" ]]; then
    alias bb="brazil-build"
    alias b="brazil"
    alias bba='brazil-build apollo-pkg'
    alias bre='brazil-runtime-exec'
    alias brc='brazil-recursive-cmd'
    alias bws='brazil ws'
    alias bwsuse='bws use --gitMode -p'
    alias bwscreate='bws create -n'
    alias bbr='brc brazil-build'
    alias bball='brc --allPackages'
    alias bbb='brc --allPackages brazil-build'
    alias bbra='bbr apollo-pkg'
    alias sam="brazil-build-tool-exec sam"
fi
# }}}


# powerlevel10k prompt {{{
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# }}}

# vim: set fdm=marker fmr={{{,}}} fdl=99 :
