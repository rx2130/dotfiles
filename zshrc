# Oh My ZSH {{{
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git z colored-man-pages history docker fzf)

source $ZSH/oh-my-zsh.sh
# }}}


# export {{{
export EDITOR='nvim'
if [ $(uname) = "Darwin" ]; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
else
    export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
    export FZF_ALT_C_COMMAND="fdfind --type d --hidden --follow --exclude .git"
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ $(uname) = "Darwin" ]; then
    # python
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
    # c/c++
    export PATH="/usr/local/opt/llvm/bin:$PATH"

    if [ $(hostname) = "3c22fb384f5f.ant.amazon.com" ]; then
        # Builder toolbox
        export PATH=$HOME/.toolbox/bin:$PATH
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
alias tm='tmux attach || tmux new'
# }}}


# source addition scripts {{{
if [ $(uname) = "Darwin" ]; then
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# }}}


# powerlevel10k prompt {{{
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# }}}

# vim: set fdm=marker fmr={{{,}}} fdl=0 :
