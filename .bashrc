export EDITOR=nvim

export GOROOT=$HOME/.g/go
export PATH=$HOME/.g/go/bin:$HOME/go/bin:$PATH

. "$HOME/.cargo/env"

alias l="ls -al"
alias vim=nvim
alias ls=exa
alias cat=bat
alias lg=lazygit

eval "$(starship init bash)"
