# Oh My ZSH {{{
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git z colored-man-pages history docker fzf)

source $ZSH/oh-my-zsh.sh
# }}}

# export {{{
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

if [ $(uname) = "Darwin" ]; then
    # python
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
    # c/c++
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    if [ $(hostname) = "xuerAli-MBP.local" ]; then
        # coc-xml
        export JAVA_HOME="$(/usr/libexec/java_home)"
    fi
else
    export PATH=~/.local/bin:$PATH
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
alias ss="https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890"
alias tm='tmux attach || tmux new'

if [ $(uname) = "Darwin" ]; then
    alias tower="gittower ."
    if [ $(hostname) = "xuerAli-MBP.local" ]; then
        alias fbp="gaa && gcmsg 'Update' && git push --set-upstream origin master && freeblock version_up && freeblock publish"
    fi
fi
# }}}

# source addition scripts {{{
if [ $(uname) = "Darwin" ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ $(hostname) = "xuerAli-MBP.local" ]; then
    [ -f ~/.tbenv/bundler-exec.sh ] && source ~/.tbenv/bundler-exec.sh
fi
# }}}

# Spaceship ZSH as a prompt {{{
autoload -U promptinit; promptinit
prompt spaceship
# }}}

# vim: set fdm=marker fmr={{{,}}} fdl=0 :

