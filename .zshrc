export HISTFILE="$HOME/.cache/zsh-history"
export HISTSIZE=10000
export SAVEHIST=10000

alias nft="sudo nft"
alias ip="ip -c"
alias vim="nvim"
alias vi="nvim"
alias ls="exa"

setopt appendhistory
setopt auto_cd

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"

source ~/.zsh/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/autosuggestions/zsh-autosuggestions.zsh
