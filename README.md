# My Dotfiles

Personal dev environment setup that I use across machines. Nothing fancy, just automates the boring stuff so I can get coding faster.

## What's in here

- **Shell setup**: Zsh with Oh My Zsh, Powerlevel10k theme, and the usual productivity plugins
- **Git config**: Bunch of useful aliases and GPG signing setup
- **Utility scripts**: Random tools I've built over time for downloading videos, checking packages, etc.
- **Cross-platform**: Works on both macOS and Linux (And no, windows doesn't count as a developer machine)

## Structure

```
dotfiles/
├── bin/                    # My custom scripts
│   ├── getVideo           # yt-dlp wrapper
│   ├── packageCheck       # Check Python package security
│   └── ...                # Other random utilities
├── config/
│   ├── zsh/               # Zsh configs and themes
│   ├── bash/              # Bash fallback
│   ├── shell_common/      # Shared stuff (aliases, functions)
│   ├── shell_work/        # Work-specific configs (empty by default)
│   └── gitconfig.aliases  # Git shortcuts I actually use
├── test/                  # Linting scripts
├── install                # Python installer script
└── uninstall              # Clean removal
```

## Installation

Just clone and run the installer:

```bash
git clone <this-repo> ~/workspace/dotfiles
cd ~/workspace/dotfiles
./install
```

The installer will:
- Back up your existing configs (adds `.backup` suffix)
- Install Oh My Zsh and plugins
- Set up symlinks for all the dotfiles
- Configure Git (it'll ask for your email)
- Set up GPG signing if you have it

## What you get

**Shell improvements:**
- Smart autocompletion and syntax highlighting
- History search that actually works
- A decent-looking prompt (Powerlevel10k)

**Git shortcuts** (just a few favorites):
```bash
git s          # status
git lo         # pretty log
git peeps      # who's been committing
git whoami     # current git identity
```

**Random utilities:**
```bash
getVideo <url>           # Download videos with sane defaults
packageCheck <package>   # Check Python package security via Snyk
```

## Removal

If you want to undo everything:

```bash
./uninstall
```

This removes symlinks and restores your original files.

## Customization

- Add work stuff to `config/shell_work/` (git ignored)
- Platform-specific aliases go in `config/shell_common/darwin.aliases.sh` or `linux.aliases.sh`
- Toss new scripts in `bin/` (included in path)

## Requirements

- Python 3.13+ (for the installer)
- Git
- GPG (optional, for commit signing)

That's about it. Feel free to fork and adapt for your own setup.
