# Oh My ZSH {{{
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git z colored-man-pages history docker fzf)

source $ZSH/oh-my-zsh.sh
# }}}


# export {{{
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ $(uname) = "Darwin" ]; then
    # python
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
    # c/c++
    # export PATH="/usr/local/opt/llvm/bin:$PATH"
    # go
    export PATH=$PATH:$(go env GOPATH)/bin
else
    export PATH=~/.local/bin:$PATH
fi

if [[ $(hostname) == *"amazon.com" ]]; then
    # Builder toolbox
    export PATH=$HOME/.toolbox/bin:$PATH
    # JDK
    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home
    # export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/
    # RDE
    fpath=(~/.zsh/completion $fpath)
    autoload -Uz compinit && compinit -i
    # CMPortalTools
    export PATH="/Users/xuerx/workplace/CMPortalTools/src/CMPortalTools/bin:$PATH"
    # curl-openssl alfred
    export PATH="/usr/local/opt/curl-openssl/bin:$PATH"
fi
# }}}


# alias {{{
alias v="nvim"
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
    if [ -x "$(command -v nvr)" ]; then
        export EDITOR='nvr'
        alias v=nvr
    fi
fi
alias www="python3 -m http.server"
alias tm='tmux attach || tmux new'

if [[ $(hostname) == *"amazon.com" ]]; then
    alias bb="brazil-build"
    alias b="brazil"
    alias bba='brazil-build apollo-pkg'
    alias bre='brazil-runtime-exec'
    alias brc='brazil-recursive-cmd'
    alias bws='brazil ws'
    alias bwsuse='bws use --gitMode -p'
    alias bwscreate='bws create -n'
    alias brc=brazil-recursive-cmd
    alias bbr='brc brazil-build'
    alias bball='brc --allPackages'
    alias bbb='brc --allPackages brazil-build'
    alias bbra='bbr apollo-pkg'
fi
# }}}


# powerlevel10k prompt {{{
if [ $(uname) = "Darwin" ]; then
    source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
else
    source /home/linuxbrew/.linuxbrew/opt/powerlevel10k/powerlevel10k.zsh-theme
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# }}}

# vim: set fdm=marker fmr={{{,}}} fdl=99 :
