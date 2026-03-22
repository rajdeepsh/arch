set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
set fish_greeting
fish_add_path $HOME/Repositories/arch-dotfiles/bin

if status is-interactive
    if not ssh-add -l &>/dev/null
        ssh-add $HOME/.ssh/rajdeepsh
    end
end