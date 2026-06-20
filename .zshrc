typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

export ZSH="$HOME/.oh-my-zsh"


ZSH_THEME="powerlevel10k/powerlevel10k"


plugins=(git)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias ls="exa -l"

export DB_PASSWORD="Qw8t2ZQM1eqCMAKD"

eval "$(ssh-agent -s)" > /dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null
export PATH="$HOME/.local/bin:$PATH"
