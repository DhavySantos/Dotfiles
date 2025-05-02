alias ip="ip -c"
alias ls="exa"

HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

## ZINIT  #########################################################################################
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-autosuggestions
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-syntax-highlighting
###################################################################################################

export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/spicetify
export EDITOR="nvim"

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
