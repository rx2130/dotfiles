# Oh My ZSH {{{
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git z colored-man-pages history docker fzf)

source $ZSH/oh-my-zsh.sh
# }}}


# export {{{
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export HOMEBREW_NO_INSTALL_UPGRADE=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

export PATH="$HOME/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin

if [ $(uname) = "Darwin" ]; then
    # c/c++
    export PATH="$PATH:/usr/local/opt/llvm/bin"
    # rust
    export PATH="$PATH:/Users/xuerx/.cargo/bin"
fi

if [[ $(hostname) == *"amazon.com" ]]; then
    # Builder toolbox
    export PATH=$PATH:$HOME/.toolbox/bin
    # JDK
    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home
    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/
    # export JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto.x86_64
    # RDE
    # fpath=(~/.zsh/completion $fpath)
    # autoload -Uz compinit && compinit -i
    # envImprovement
    export PATH="$PATH:/apollo/env/envImprovement/bin"
fi

export VISUAL="nvim"
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    export VISUAL="nvr -cc split --remote-wait +'setlocal bufhidden=wipe'"
fi
export MANPAGER="$VISUAL +Man! -"
# }}}


# alias {{{
alias v=$VISUAL
alias www="python3 -m http.server"
alias tm='tmux attach || tmux new'
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
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# }}}

# vim: set fdm=marker fmr={{{,}}} fdl=99 :
