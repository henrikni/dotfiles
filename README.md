# My personal dotfiles

This is my personal collection of dotfiles. 

## Setup

Setup Plug as the vim plugin manager:

```
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Open vim and run `:PlugInstall`.

Setup tpm as the tmux plugin manager:

```
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Open tmux and install plugins using `ctrl+b` + `I`.

Create symlinks into the home directory:

| Source          | Target             |
| --------------- | ------------------ |
| `wezterm.lua`   | `~/.wezterm.lua`   |
| `vim.conf`      | `~/.vimrc`         |
| `tmux.conf`     | `~/.tmux.conf`     |
| `bashrc.d/`     | `~/.bashrc.d/`     |
| `git_prompt.sh` | `~/.git_prompt.sh` |

If not already done, add the following to `~/.bashrc`:

```
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
     . "$rc"
    fi
  done
fi
unset rc
```

