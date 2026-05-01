# WezTerm Config

Modular WezTerm configuration for Windows/macOS/Linux. Catppuccin Macchiato theme, Ghostty-style keybindings.

Forked from [KevinSilvester/wezterm-config](https://github.com/KevinSilvester/wezterm-config), heavily modified.

![screenshot](./.github/screenshots/wezterm.gif)

## Features

- Cross-platform (Windows native + WSL, macOS, Linux) with no code changes
- Catppuccin Macchiato color scheme with consistent palette across all UI elements
- Ghostty-style `Ctrl+Shift` keybindings (configurable via env vars)
- Tab capsules with process names, unseen-output badges, WSL/admin icons
- Status bars: leader/key-table indicator (left), date + battery (right)
- Background wallpaper system with cycle, random, fuzzy search, and focus mode
- Right-click new-tab button with domain selector (WSL, SSH, shells)
- Per-machine customization via environment variables

## Quick Start

1. Install [WezTerm](https://wezfurlong.org/wezterm/installation.html)
2. Install [FiraCode Nerd Font](https://www.nerdfonts.com/) and [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)
3. Clone into your WezTerm config directory:
   ```sh
   # macOS/Linux
   git clone https://github.com/aziraphail/wezterm-config.git ~/.config/wezterm

   # Windows
   git clone https://github.com/aziraphail/wezterm-config.git "%USERPROFILE%\.config\wezterm"
   ```
4. Launch WezTerm

## Structure

```
wezterm.lua              # Entry point
config/
  init.lua               # Config builder (chainable :append() pattern)
  appearance.lua         # Colors, WebGPU, scrollbar, cursor
  bindings.lua           # Keybindings (Ghostty-style Ctrl+Shift)
  domains.lua            # WSL/SSH/Unix domains
  fonts.lua              # Font stack with per-OS sizing
  general.lua            # Scrollback, hyperlinks, bell
  launch.lua             # Default shells, launch menu
events/
  tab-title.lua          # Tab capsules, rename, toggle
  left-status.lua        # Leader/key-table indicator
  right-status.lua       # Date + battery
  new-tab-button.lua     # Right-click domain selector
  gui-startup.lua        # Maximize on launch
utils/
  backdrops.lua          # Wallpaper manager
  cells.lua              # Format item builder
  env.lua                # Environment variable parsing
  platform.lua           # OS detection
  math.lua               # clamp, round
colors/custom.lua        # Catppuccin Macchiato palette
```

## Keybindings

Follows Ghostty terminal conventions. Full reference in [`docs/keybindings.md`](docs/keybindings.md).

| Modifier | Windows/Linux | macOS |
|----------|--------------|-------|
| `SUPER` | `Ctrl+Shift` | `Cmd` |
| `SUPER_REV` | `Ctrl+Alt` | `Cmd+Ctrl` |
| Leader | `Ctrl+Alt+Space` | `Cmd+Ctrl+Space` |

**Highlights:**
- `Ctrl+Shift+T` — new tab
- `Ctrl+Shift+W` — close surface (pane if multiple, tab if last)
- `Ctrl+Shift+D/E` — split right / split down
- `Ctrl+Alt+Arrow keys` — navigate panes
- `Ctrl+Shift+L` — launch menu selector
- `Alt+1-9` — switch to tab
- `Ctrl+Shift+B` — toggle background focus mode
- `Leader+B` then `R/N/P/S` — random/next/prev/select background

## Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `WEZTERM_FONT` | Primary font family | `FiraCode Nerd Font` |
| `WEZTERM_FONT_FALLBACK` | Fallback font | `JetBrainsMono Nerd Font` |
| `WEZTERM_FONT_SIZE` | Font size override | `13` (Win), `12` (Mac), `10` (Linux) |
| `WEZTERM_FRONT_END` | Rendering backend | `WebGpu` |
| `WEZTERM_SUPER_KEY` | Override modifier key | `CTRL\|SHIFT` (Win/Linux), `SUPER` (Mac) |
| `WEZTERM_BACKDROP_DIR` | Wallpaper directory | `backdrops/` |
| `WEZTERM_FOCUS_COLOR` | Focus mode background | Macchiato base |
| `WEZTERM_BACKDROP_FOCUS_MODE` | Start in focus mode | `false` |
| `WEZTERM_DISABLE_RANDOM_BACKDROP` | Skip random wallpaper on launch | `false` |
| `WEZTERM_DEFAULT_PROG` | Default shell command | `/bin/bash -l` (Mac/Linux), WSL default (Win) |
| `WEZTERM_DEFAULT_DOMAIN` | Default domain | First WSL domain (Win) |
| `WEZTERM_ENABLE_WSL` | Auto-discover WSL domains | `true` |
| `WEZTERM_WSL_ORDER` | Preferred WSL distro order | `Ubuntu` |
| `WEZTERM_WSL_USER` | WSL username | `suhail` |
| `WEZTERM_WSL_HOME` | WSL home directory | `/home/<user>` |
| `WEZTERM_GIT_BASH` | Git Bash path (Windows) | Auto-detected |
| `WEZTERM_NUSHELL_EXE` | Nushell binary path | `nu` |
| `WEZTERM_SSH_REMOTE` | SSH host for domain | — |
| `WEZTERM_SSH_DOMAIN_NAME` | SSH domain display name | `ssh:remote` |
| `WEZTERM_SSH_MULTIPLEXING` | SSH multiplexing mode | `None` |
| `WEZTERM_SSH_ASSUME_SHELL` | SSH shell type | `Posix` |

### Host Overrides

Create `config/launch_local.lua` returning `{ default_prog = {...}, launch_menu = {...} }` to override launch settings per machine. The file is loaded via `pcall` — missing files are silently ignored.

## Credits

- Original config: [KevinSilvester/wezterm-config](https://github.com/KevinSilvester/wezterm-config)
- Color scheme: [Catppuccin Macchiato](https://github.com/catppuccin/catppuccin)
- Tab styling inspired by [wez/wezterm#628](https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614)
