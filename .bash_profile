export EDITOR="nvim"
export FZF_CTRL_R_OPTS="--reverse"
export FZF_DEFAULT_OPTS="--color=light"
export LANG="en_US.UTF-8"

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="\
$HOME/.local/bin:\
$HOME/.cargo/bin:\
$HOME/go/bin:\
/opt/homebrew/opt/llvm/bin:\
$PATH"

if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
