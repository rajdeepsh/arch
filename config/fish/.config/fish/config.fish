set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set fish_greeting

alias ls 'eza -lh --group-directories-first --icons=auto'
alias lsa 'ls -a'
alias lt 'eza --tree --level=2 --long --icons --git'
alias lta 'lt -a'

if status is-interactive
    if not ssh-add -l &>/dev/null
        ssh-add $HOME/.ssh/rajdeepsh
    end
end
