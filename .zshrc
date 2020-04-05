# Oh My ZSH {{{
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git z colored-man-pages history docker fzf)

source $ZSH/oh-my-zsh.sh
# }}}

# export {{{
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git/' --glob '!node_modules'"

if [ $(uname) = "Darwin" ]; then
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    if [ $(hostname) = "xuerAli-MBP.local" ]; then
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
alias ss="https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891"
alias gg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

# Try bat, highlight, coderay, rougify in turn, then fall back to cat
alias ff="fzf --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'"

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

