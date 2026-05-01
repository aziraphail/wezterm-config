# WezTerm Config

Modular WezTerm configuration for Windows/macOS/Linux. Lua 5.4, Catppuccin Macchiato theme.

## Structure

```
wezterm.lua              # Entry point: composes config, registers events, seeds backdrops
config/
  init.lua               # Config builder (chainable :append() pattern)
  appearance.lua         # Colors, WebGPU, scrollbar, cursor
  bindings.lua           # Keybindings (Ghostty-style Ctrl+Shift layout)
  domains.lua            # WSL/SSH/Unix domains
  fonts.lua              # Font stack with per-OS sizing
  general.lua            # Behavior toggles (scrollback, hyperlinks, bell)
  launch.lua             # Default shells, launch menu per platform
events/
  gui-startup.lua        # Maximize on launch
  left-status.lua        # Left bar: leader/key-table indicators
  right-status.lua       # Right bar: date, battery (conditional)
  new-tab-button.lua     # Right-click new-tab: InputSelector with icons
  tab-title.lua          # Tab capsules: process names, unseen badges, WSL/admin icons
utils/
  env.lua                # Env var parsing (string/bool/number)
  platform.lua           # OS detection booleans
  backdrops.lua          # Wallpaper manager (cycle, random, focus mode)
  cells.lua              # Format item builder for wezterm.format()
  math.lua               # clamp, round
colors/custom.lua        # Catppuccin Macchiato palette
docs/keybindings.md      # Full keybinding reference
```

## Key Patterns

- **Config modules** return plain tables, composed via `Config:init():append(...)`. Domains must be appended before Launch (launch.lua references `domains.wsl_domains`).
- **Event modules** export `.setup()` which registers `wezterm.on(...)` handlers.
- **Cells utility** (`utils/cells.lua`): Segment-based builder for `wezterm.format()`. Used by all event modules for styled text rendering.
- **Environment variables** for per-machine config: `WEZTERM_SUPER_KEY`, `WEZTERM_FONT`, `WEZTERM_FONT_SIZE`, `WEZTERM_BACKDROP_DIR`, `WEZTERM_FRONT_END`, etc.
- **Host overrides**: `config/launch_local.lua` (optional, pcall-loaded) for machine-specific launch menu.

## Color Architecture

- **`colors/custom.lua`** is the canonical Catppuccin Macchiato palette (fg/bg, ANSI 0-15, cursor, selection, tab_bar, scrollbar, split, visual_bell).
- **Event files have their own hardcoded hex colors** — `tab-title.lua`, `left-status.lua`, `right-status.lua`, `new-tab-button.lua` each define local `colors` tables. When changing the theme, ALL of these must be updated manually.
- `rgba(0, 0, 0, 0.4)` backgrounds in status bars/tabs are intentionally fixed, not theme-dependent.

## Custom Events

Three custom events are defined in `events/tab-title.lua` and triggered from `config/bindings.lua`:
- `tabs.manual-update-tab-title` — prompts user for tab name, locks it
- `tabs.reset-tab-title` — unlocks manually set tab name
- `tabs.toggle-tab-bar` — toggles tab bar visibility

## Font Configuration

Tuned for Windows Terminal-like sharpness — don't change without testing:
- FiraCode Nerd Font, **Medium** weight, size **13** on Windows (12 mac, 10 linux)
- FreeType load/render target: **Normal**
- Line height: **1.1**

## Keybinding Conventions

Ghostty-style: `Ctrl+Shift` (primary), `Ctrl+Alt` (secondary), `Alt+1-9` (tabs), Leader=`Ctrl+Alt+Space`. `Ctrl+Shift+W` = unified close surface (pane if multiple, tab if last). Avoid symbol keys with Ctrl+Shift (Shift transforms them on Windows). Full reference in `docs/keybindings.md`.

## Important WezTerm Quirks

- `SplitHorizontal` = pane to the **right** (dividing line is horizontal). `SplitVertical` = pane **below**. Names refer to the dividing line, not the direction.
- `backdrops:set_images()` must be called in `wezterm.lua` before event registration (glob doesn't work in subprocesses).
- `wezterm.battery_info()` returns empty table on desktops — always guard with `#info > 0`.
- `update-right-status` is deprecated; use `update-status` instead.
- Default key bindings are disabled (`disable_default_key_bindings = true`); default mouse bindings are kept.

## Git

- Remote: https://github.com/aziraphail/wezterm-config
- Single `master` branch, push directly
