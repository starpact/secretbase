HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups

eval "$(mise activate bash)"
eval "$(fzf --bash)"
eval "$(starship init bash)"
eval "$(direnv hook bash)"

alias gp='git pull'
alias gs='git status'
alias l='ls -hl'
alias la='ls -ahl'
alias ls=eza
alias ta='tmux a'
alias vim=nvim
alias python=python3

if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

if [[ -r ~/.private ]]; then
    source ~/.private
fi
