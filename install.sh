#!/usr/bin/env bash
set -euo pipefail

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# dotfiles installer — one-shot setup for a fresh macOS
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Usage: git clone git@github.com:michaelmonetized/dotfiles.git ~/.config
#        cd ~/.config && ./install.sh

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[✓]${NC} $*"; }
warn()  { echo -e "${YELLOW}[!]${NC} $*"; }
error() { echo -e "${RED}[✗]${NC} $*"; }
step()  { echo -e "\n${YELLOW}━━━ $* ━━━${NC}"; }

# ── Pre-flight ──────────────────────────────────────────
step "Pre-flight checks"

if [[ "$(uname)" != "Darwin" ]]; then
  error "This script is for macOS only."
  exit 1
fi

if [[ "$DOTFILES" != "$HOME/.config" ]]; then
  warn "Dotfiles not at ~/.config — symlinking"
  if [[ -d "$HOME/.config" && ! -L "$HOME/.config" ]]; then
    warn "Backing up existing ~/.config to ~/.config.bak"
    mv "$HOME/.config" "$HOME/.config.bak"
  fi
  ln -sfn "$DOTFILES" "$HOME/.config"
  info "Symlinked $DOTFILES → ~/.config"
else
  info "Dotfiles already at ~/.config"
fi

# ── Xcode CLI Tools ────────────────────────────────────
step "Xcode Command Line Tools"
if xcode-select -p &>/dev/null; then
  info "Already installed"
else
  warn "Installing Xcode CLI tools..."
  xcode-select --install
  echo "Press Enter after Xcode CLI tools finish installing..."
  read -r
fi

# ── Homebrew ────────────────────────────────────────────
step "Homebrew"
if command -v brew &>/dev/null; then
  info "Already installed"
else
  warn "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── Homebrew Taps ───────────────────────────────────────
step "Homebrew taps"
TAPS=(
  felixkratz/formulae        # sketchybar
  koekeishiya/formulae       # yabai, skhd
  steipete/tap               # bird, gogcli, peekaboo, remindctl, sag
  withgraphite/tap           # graphite
  yakitrak/yakitrak          # obsidian-cli
  yqrashawn/goku             # goku (karabiner)
  thezoraiz/ascii-image-converter
  antoniorodr/memo           # memo (Apple Notes CLI)
)
for tap in "${TAPS[@]}"; do
  brew tap "$tap" 2>/dev/null || true
done
info "Taps configured"

# ── Homebrew Formulae ───────────────────────────────────
step "Homebrew formulae"
FORMULAE=(
  # Core utils
  aria2 bat btop cmatrix direnv duf eza fd fzf htop jq
  micro neofetch neovim ripgrep shellcheck shfmt silicon
  sox thefuck tlrc tmux tokei tree wget zoxide
  zsh-autosuggestions

  # Dev tools
  cmake gh git-delta git-filter-repo go uv zig

  # Networking / infra
  caddy cloudflared dnsmasq mkcert sshs tailscale

  # Media
  ffmpeg

  # Git workflow
  withgraphite/tap/graphite
  lazygit

  # macOS window management
  felixkratz/formulae/sketchybar
  koekeishiya/formulae/skhd
  koekeishiya/formulae/yabai

  # CLIs
  steipete/tap/bird
  steipete/tap/gogcli
  steipete/tap/peekaboo
  steipete/tap/remindctl
  steipete/tap/sag
  antoniorodr/memo/memo
  yakitrak/yakitrak/obsidian-cli
  yqrashawn/goku/goku
  thezoraiz/ascii-image-converter/ascii-image-converter

  # Other
  atuin
  flyctl
  huggingface-cli
  mongosh
  pipx
  whisper-cpp
  wp-cli
  yazi
)

for formula in "${FORMULAE[@]}"; do
  if brew list --formula "$formula" &>/dev/null; then
    info "$formula ✓"
  else
    warn "Installing $formula..."
    brew install "$formula" || error "Failed: $formula"
  fi
done

# ── Homebrew Casks ──────────────────────────────────────
step "Homebrew casks"
CASKS=(
  ghostty
  obsidian
  font-noto-nerd-font
  keycastr
  ngrok
  gimp
  inkscape
)

for cask in "${CASKS[@]}"; do
  if brew list --cask "$cask" &>/dev/null; then
    info "$cask ✓"
  else
    warn "Installing $cask..."
    brew install --cask "$cask" || error "Failed: $cask"
  fi
done

# ── Bun ─────────────────────────────────────────────────
step "Bun"
if command -v bun &>/dev/null; then
  info "Already installed ($(bun --version))"
else
  warn "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  export PATH="$HOME/.bun/bin:$PATH"
fi

# ── Node.js (via bun or nvm) ───────────────────────────
step "Node.js"
if command -v node &>/dev/null; then
  info "Already installed ($(node --version))"
else
  warn "Installing Node.js via bun..."
  bun install -g node || warn "Install Node.js manually if needed"
fi

# ── Bun Global Packages ────────────────────────────────
step "Bun global packages"
BUN_GLOBALS=(
  openclaw
  vercel
  eas-cli
  @sentry/cli
  clawhub
)
for pkg in "${BUN_GLOBALS[@]}"; do
  warn "Installing $pkg..."
  bun install -g "$pkg" || error "Failed: $pkg"
done
info "Bun globals installed"

# ── Claude Code ─────────────────────────────────────────
step "Claude Code"
if command -v claude &>/dev/null; then
  info "Already installed ($(claude --version 2>/dev/null || echo 'unknown'))"
else
  warn "Installing Claude Code..."
  # Claude Code self-installs to ~/.local/share/claude/
  curl -fsSL https://claude.ai/install.sh | bash || warn "Install Claude Code manually: https://docs.anthropic.com/claude-code"
fi

# ── CodeRabbit ──────────────────────────────────────────
step "CodeRabbit"
if command -v coderabbit &>/dev/null; then
  info "Already installed"
else
  warn "Installing CodeRabbit..."
  # Download latest arm64 binary
  CR_URL="https://github.com/coderabbitai/coderabbit-cli/releases/latest/download/coderabbit-darwin-arm64"
  mkdir -p ~/.local/bin
  curl -fsSL "$CR_URL" -o ~/.local/bin/coderabbit || warn "Download CodeRabbit manually"
  chmod +x ~/.local/bin/coderabbit
  ln -sf ~/.local/bin/coderabbit ~/.local/bin/cr
  info "Installed coderabbit → ~/.local/bin/"
fi

# ── Cursor Agent ────────────────────────────────────────
step "Cursor Agent"
if command -v cursor-agent &>/dev/null; then
  info "Already installed"
else
  warn "Install Cursor Agent manually — requires Cursor app"
  warn "https://docs.cursor.com/agent"
fi

# ── Directories ─────────────────────────────────────────
step "Directory structure"
mkdir -p ~/bin
mkdir -p ~/.local/bin
mkdir -p ~/.local/log
mkdir -p ~/.local/ssl
mkdir -p ~/.local/etc
mkdir -p ~/Projects
mkdir -p ~/Cloud/Reports/proposals
info "Directories created"

# ── ~/bin scripts ───────────────────────────────────────
step "~/bin scripts"
if [[ -d "$DOTFILES/bin" ]]; then
  # Copy all scripts from dotfiles/bin to ~/bin
  for script in "$DOTFILES/bin/"*; do
    name="$(basename "$script")"
    # Skip node_modules, __pycache__, and lock files
    [[ "$name" == "node_modules" || "$name" == "__pycache__" || "$name" == "bun.lock" || "$name" == "package.json" ]] && continue
    if [[ -f "$script" ]]; then
      cp "$script" "$HOME/bin/$name"
      chmod +x "$HOME/bin/$name"
    elif [[ -d "$script" ]]; then
      cp -r "$script" "$HOME/bin/$name"
    fi
  done
  info "Scripts copied to ~/bin"

  # Install bin dependencies if package.json exists
  if [[ -f "$DOTFILES/bin/package.json" ]]; then
    warn "Installing ~/bin node dependencies..."
    cd "$HOME/bin" && bun install && cd -
  fi
else
  warn "No bin/ directory found in dotfiles"
fi

# ── Symlinks ────────────────────────────────────────────
step "Symlinks"

# ~/.zshrc → dotfiles zsh entrypoint
if [[ -f "$DOTFILES/zsh/rc" ]]; then
  ln -sf "$DOTFILES/zsh/rc" "$HOME/.zshrc"
  info ".zshrc → zsh/rc"
fi

# ~/.gitconfig — copy template if not present (user-specific, not symlinked)
if [[ ! -f "$HOME/.gitconfig" ]]; then
  cat > "$HOME/.gitconfig" <<'GITEOF'
[user]
	name = Michael Monetized
	email = michaelmonetized@gmail.com
[core]
	excludesFile = ~/.config/git/ignore
	pager = delta
[interactive]
	diffFilter = delta --color-only
[delta]
	navigate = true
	side-by-side = true
	line-numbers = true
[merge]
	conflictstyle = diff3
[diff]
	colorMoved = default
[init]
	defaultBranch = main
[push]
	autoSetupRemote = true
GITEOF
  info ".gitconfig created"
else
  info ".gitconfig already exists"
fi

# ~/.tmux.conf
if [[ -f "$DOTFILES/tmux/tmux.conf" ]]; then
  ln -sf "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
  info ".tmux.conf → tmux/tmux.conf"
fi

# XDG configs are automatic since $DOTFILES == ~/.config
# These are already in place: ghostty, nvim, gh, atuin, yabai, skhd,
# sketchybar, borders, karabiner, zsh, tmux-powerline, etc.
info "XDG configs (ghostty, nvim, gh, etc.) ✓ — ~/.config is dotfiles repo"

info "Symlinks configured"

# ── PATH setup ──────────────────────────────────────────
step "PATH verification"
EXPECTED_PATHS=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.bun/bin"
  "/opt/homebrew/bin"
)

for p in "${EXPECTED_PATHS[@]}"; do
  if echo "$PATH" | tr ':' '\n' | grep -q "^${p}$"; then
    info "$p ✓ in PATH"
  else
    warn "$p not in PATH — make sure your .zshrc adds it"
  fi
done

# ── macOS Defaults ──────────────────────────────────────
step "macOS defaults"

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

# Disable press-and-hold for keys (enable key repeat)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Dock: auto-hide, small icons
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 36

# Disable DS_Store on network/USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

info "macOS defaults set (restart Dock/Finder to apply)"
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

# ── SSL certs (mkcert) ─────────────────────────────────
step "Local SSL (mkcert)"
if command -v mkcert &>/dev/null; then
  mkcert -install 2>/dev/null || true
  if [[ ! -f "$HOME/.local/ssl/start.localhost.pem" ]]; then
    warn "Generating start.localhost certs..."
    mkcert -cert-file "$HOME/.local/ssl/start.localhost.pem" \
           -key-file "$HOME/.local/ssl/start.localhost-key.pem" \
           start.localhost localhost 127.0.0.1 ::1
  fi
  info "SSL certs ready"
else
  warn "mkcert not found — skipping SSL setup"
fi

# ── Goku (Karabiner config) ────────────────────────────
step "Goku (Karabiner)"
if command -v goku &>/dev/null && [[ -f "$DOTFILES/karabiner.edn" ]]; then
  warn "Running goku..."
  goku || warn "Goku failed — check karabiner.edn"
else
  warn "Skipping goku (not installed or no karabiner.edn)"
fi

# ── tmux plugin manager ────────────────────────────────
step "tmux plugins"
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ -d "$TPM_DIR" ]]; then
  info "TPM already installed"
else
  warn "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  info "TPM installed — run prefix+I in tmux to install plugins"
fi

# ── Summary ─────────────────────────────────────────────
step "Done! 🎉"

cat <<'EOF'

  ┌──────────────────────────────────────────────────┐
  │                 Setup Complete!                    │
  │                                                    │
  │  Manual steps remaining:                           │
  │                                                    │
  │  1. source ~/.zshrc                                │
  │  2. Log into GitHub:  gh auth login                │
  │  3. Log into Graphite: gt auth                     │
  │  4. Log into Vercel: vercel login                  │
  │  5. Log into Fly: fly auth login                   │
  │  6. Configure OpenClaw: openclaw setup             │
  │  7. Configure bird: bird auth                      │
  │  8. Configure gog: gog auth                        │
  │  9. Start yabai/skhd: brew services start yabai    │
  │ 10. Start sketchybar: brew services start sketchybar│
  │ 11. tmux: prefix+I to install plugins              │
  │ 12. Install Mac apps from App Store                │
  │     (1Password, Raycast, Slack, Discord, etc.)     │
  │                                                    │
  └──────────────────────────────────────────────────┘

EOF
