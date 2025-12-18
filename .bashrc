HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups

set -o emacs

alias gp='git pull'
alias gs='git status'
alias l='ls -hl'
alias la='ls -ahl'
alias ls=eza
alias ta='tmux a'
alias vim=nvim
alias python=python3

eval "$(fzf --bash)"
eval "$(starship init bash)"
eval "$(direnv hook bash)"

HOMEBREW_PREFIX="$(brew --prefix)"
[[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"

[[ -r ~/.private ]] && source ~/.private
