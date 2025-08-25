export ZSH_COMPDUMP="$HOME/.cache/.zcompdump-$HOST"
export ZSH="$HOME/.oh-my-zsh"

if [[ ! -d "$ZSH" ]]; then
  git clone https://github.com/ohmyzsh/ohmyzsh  $ZSH
fi

if [[ ! -d "$ZSH/plugins/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH/plugins/zsh-autosuggestions"
fi

if [[ ! -d "$ZSH/plugins/zsh-syntax-highlighting" ]]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH/plugins/zsh-syntax-highlighting"
fi

if [[ ! -d "$ZSH/plugins/zsh-autocomplete" ]]; then
  git clone https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH/plugins/zsh-autocomplete"
fi

ZSH_TMUX_UNICODE="true"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="true"
ZSH_TMUX_AUTOSTART_ONCE="true"
ZSH_TMUX_DEFAULT_SESSION_NAME="Default"

plugins=(
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-autocomplete
	tmux
)

source $ZSH/oh-my-zsh.sh

HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=10000

export EDITOR="nvim"

alias ls="exa -la --group-directories-first"
alias ip="ip -c"

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
