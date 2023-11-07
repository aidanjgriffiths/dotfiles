# Dotfiles

Dotfiles to share to different servers with `ansible` for Fedora and MacOS targets.

### Usage

This dotfiles repo is configured with an ansible playbook to provision `nvim`, `tmux`, `zsh` and `miniconda3`
configs to the current users home directory on `localhost`. This playbook will forcibly create symlinks,
if there are any local configuration files on target then they will be overriden. The playbook
also requires sudo permissions to install required core dependencies from the targets package managers for each task.
You may see duplicated dependencies across different tasks, this is done deliberately to ensure each
role works independently to avoid any potential dependency coupling.

```
ansible-playbook dotfiles.yml --ask-become-pass
```

Roles have been made for each decrete development dependency and will select the correct
tasks depending on the target host. This solution has been chosen to easily introduce different
targets in the future. See `tree` output below:

```bash
roles
├── miniconda
│   └── main.yml
├── nvim
│   └── tasks
│       ├── fedora.yml
│       ├── macos.yml
│       └── main.yml
├── tmux
│   ├── files
│   │   └── main.yml
│   └── tasks
│       ├── fedora.yml
│       ├── macos.yml
│       └── main.yml
└── zsh
    └── tasks
        ├── fedora.yml
        ├── macos.yml
        └── main.yml
```
