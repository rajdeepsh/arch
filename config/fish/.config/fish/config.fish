set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set fish_greeting

alias ls 'eza -lh -F never --color=always --icons=always --group-directories-first --show-symlinks -s name'
alias lsa 'ls -a'
alias lt 'ls -T --git'
alias lta 'lt -a'

if status is-interactive
    if not ssh-add -l &>/dev/null
        ssh-add $HOME/.ssh/rajdeepsh
    end
end
