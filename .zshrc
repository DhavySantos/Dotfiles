export HISTFILE="$HOME/.cache/zsh-history"

alias ip="ip -c"
alias vim="nvim"
alias vi="nvim"
alias ls="exa"

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"

source ~/.zsh/plugins/syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/autosuggestions/zsh-autosuggestions.zsh
