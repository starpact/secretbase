path=(
  $HOME/bin
  $HOME/.cargo/bin
  $HOME/go/bin
  $HOME/.npm-global/bin
  $(brew --prefix llvm)/bin
  $path
)

bindkey -e

fpath+=("$(brew --prefix)/share/zsh/site-functions")

autoload -U compinit && compinit

alias -- gp='git pull'
alias -- gs='git status'
alias -- l='ls -hl'
alias -- la='ls -ahl'
alias -- ls=eza
alias -- ta='tmux a'
alias -- vim=nvim

source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
