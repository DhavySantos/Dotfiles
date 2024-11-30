export HISTFILE="$HOME/.cache/zsh-history"
export ZSH="$HOME/.ohmyzsh"

plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
  colorize
)

ZSH_COLORIZE_CHROMA_FORMATTER=terminal256
ZSH_COLORIZE_STYLE="colorful"
ZSH_COLORIZE_TOOL=chroma

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

source $ZSH/oh-my-zsh.sh

zstyle ':completion:*' list-colors 'no=00;32'
zstyle ':completion:*' use-comp-desc yes
zstyle ':completion:*' rehash true

autoload -Uz compdef && compdef _git git
autoload -Uz compinit && compinit

alias nft="sudo nft"
alias ip="ip -c"
alias ls="exa"

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
