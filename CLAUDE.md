# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository for macOS development environment. Contains configurations for shell, editors, window management, and development tools. Located at `~/.config`.

## Architecture

### Modular Zsh Configuration
The shell config uses a modular pattern where `zsh/rc` sources separate files:
- `zsh/zinit` - Plugin manager setup
- `zsh/keybindings` - Custom keybindings
- `zsh/history` - History configuration
- `zsh/completions` - Completion styling
- `zsh/aliases` - Shell aliases
- `zsh/integrations` - Tool integrations (bun, etc.)
- `zsh/fzf` - Fuzzy finder config
- `zsh/git` - Git wrapper functions with custom behaviors
- `zsh/next` - Next.js helpers

### Git Workflow Customization
`zsh/git` wraps git commands with custom behaviors:
- `git commit` triggers Raycast confetti on success
- `git push` runs `ascii-commit-graph` visualization on success
- `gitcp` alias for quick add/commit/push
- `ga` function integrates with Graphite: adds, creates PR, submits

### Neovim (NvChad)
`nvim/init.lua` bootstraps Lazy.nvim and loads NvChad v2.5. Custom configs in `nvim/lua/configs/`:
- catppuccin, gitsigns, neogit, noice, notify, nvimtree, supermaven
- Custom theme module: `nvim/lua/nvibe/`

### macOS Window Management
- **yabai** (`yabai/yabairc`) - BSP tiling, window opacity, app-to-space assignments
- **skhd** - Hotkey daemon (started by yabai)
- **sketchybar** - Custom status bar
- **borders** - Window border decorations
- **karabiner** - Keyboard remapping (option+key → control+number)

### Tool Stack
- **Terminals**: WezTerm (primary), Alacritty, Ghostty
- **Editors**: Neovim/NvChad, Cursor, VS Code, Zed
- **Shell**: zsh with Powerlevel10k, zinit plugins
- **CLI tools**: ripgrep, bat, eza, delta, fzf, zoxide, jq, thefuck
- **Git workflow**: Graphite (`gt` commands)

## Key Files

| File | Purpose |
|------|---------|
| `zsh/rc` | Main shell config, sources all modules |
| `zsh/git` | Git command wrappers and Graphite integration |
| `nvim/init.lua` | Neovim entry point |
| `yabai/yabairc` | Window manager config |
| `yabai/reload.sh` | Restart yabai/skhd services |
| `karabiner/karabiner.json` | Keyboard remapping rules |
| `goku/goku.edn` | Karabiner config in EDN format |

## Reload Commands

```bash
# Reload yabai and skhd
~/.config/yabai/reload.sh

# Reload zsh config
source ~/.zshrc

# Restart sketchybar
brew services restart sketchybar
```

## Development Roadmap

See `PLAN.md` for improvement priorities:
- Critical: Installation script, secrets separation, version tracking
- High: Platform compatibility (macOS vs Linux), Brewfile for dependencies
- Nice-to-have: Theme sync across tools, automated font setup

## Conventions

- Catppuccin theme family used across tools (Macchiato/Latte variants)
- Config files use conditional sourcing pattern: `[[ ! -f path ]] || source path`
- Raycast extensions stored in `raycast/extensions/` by UUID
- Global gitignore at `git/ignore`
