export ZSH_COMPDUMP="${ZDOTDIR:-${ZSH}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
export HISTFILE=~/.cache/zsh_history

plugins=(tmux)

source $HOME/.oh-my-zsh/oh-my-zsh.sh
source $HOME/.zplug/init.zsh

ZSH_TMUX_DEFAULT_SESSION_NAME="Default"
ZSH_TMUX_AUTOSTART_ONCE="true"
ZSH_TMUX_AUTOCONNECT="true"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_UNICODE="true"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug load

alias ls="exa"

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
