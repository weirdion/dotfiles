# Dotfiles

This repository contains my personal configuration files and setup scripts for managing my development environments.


## Folder Structure

```
dotfiles/
├── bin/ # Custom scripts and utilities
├── config/
│ ├── bash/ # Bash-specific configuration files
│ ├── zsh/ # Zsh-specific configuration files
│ └── .vimrc # Vim configuration file
├── test/ # Scripts for linting and testing
│ ├── python-lint.py # Linter for Python scripts with shebang
│ └── shellcheck-run.sh # ShellCheck script for linting shell
├── install # Main installation script
├── uninstall # Main uninstallation script
└── .github/ # GitHub Actions workflow for CI
```

## What This Repository Sets Up

1. **Zsh Configuration**:
    - Installs [Oh My Zsh](https://ohmyz.sh/).
    - Sets up the Powerlevel10k theme.
    - Installs Zsh plugins:
        - `zsh-autosuggestions`
        - `zsh-completions`
        - `zsh-history-substring-search`
        - `zsh-syntax-highlighting`
    - Configures `.zshrc` and `.zshenv`.

2. **Bash Configuration**:
    - Configures `.bashrc`.

3. **Vim Configuration**:
    - Sets up `.vimrc` for Vim.

4. **Custom Scripts**:
    - Includes utility scripts in the `bin/` directory.

5. **Git Configuration**:
    - Configures Git with user details, aliases, and GPG signing.
    - GPG signing only works if
        - GPG2 is installed
        - The email associated in user details is set up in GPG2 already.

6. **Symlinks**:
    - Creates symlinks for configuration files and directories in the home directory.
