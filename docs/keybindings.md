# Key Bindings Reference

This config disables WezTerm's built-in key bindings (`disable_default_key_bindings = true`), so **every active shortcut is defined in `config/bindings.lua`**. Default mouse bindings remain active (copy-on-select works out of the box).

## Modifier Legend

| Symbol | Windows / Linux | macOS |
| ------ | ---------------- | ------ |
| `SUPER` | `ALT` | `⌘ (Command)` |
| `SUPER_REV` | `ALT + CTRL` | `⌘ + CTRL` |
| `LEADER` | `SUPER_REV + Space` (3s timeout) | Same |

## Misc / Global

| Keys | Action |
| ---- | ------ |
| `F1` | Activate copy mode |
| `F2` | Command palette |
| `F3` | Launcher (full list) |
| `F4` | Fuzzy tab launcher |
| `F5` | Fuzzy workspace launcher |
| `F11` | Toggle fullscreen |
| `F12` | Debug overlay |
| `SUPER + f` | Search (case-insensitive) |
| `SUPER + l` | Fuzzy launch selector (profiles with icons) |
| `SUPER_REV + u` | QuickSelect URLs and open in browser |
| `SUPER + Left/Right` | Send Home/End (terminal-level) |
| `SUPER + Backspace` | Delete line backwards (Ctrl+U) |
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `Ctrl + Click` | Open link at mouse cursor |

## Tabs

| Keys | Action |
| ---- | ------ |
| `SUPER + t` | New tab (default domain) |
| `SUPER + 1-8` | Switch to tab 1-8 |
| `SUPER + 9` | Switch to last tab |
| `SUPER + [` / `]` | Previous / next tab |
| `SUPER_REV + [` / `]` | Move tab left / right |
| `SUPER_REV + w` | Close current tab (no prompt) |
| `SUPER_REV + 0` | Rename current tab (prompt) |
| `SUPER_REV + 9` | Toggle tab bar visibility |

## Windows

| Keys | Action |
| ---- | ------ |
| `SUPER + n` | Spawn new window |
| `SUPER + -` / `=` | Shrink / grow window (50px, ignored in fullscreen) |
| `SUPER_REV + Enter` | Maximize window |

## Panes

| Keys | Action |
| ---- | ------ |
| `SUPER + \` | Split vertically |
| `SUPER_REV + \` | Split horizontally |
| `SUPER + Enter` | Toggle pane zoom |
| `SUPER + w` | Close current pane |
| `SUPER_REV + k/j/h/l` | Move focus Up/Down/Left/Right |
| `SUPER_REV + p` | Pane select (swap with active, keep focus) |
| `SUPER + u/d` | Scroll up/down 5 lines |
| `PageUp / PageDown` | Scroll 0.75 page |

## Background Controls

| Keys | Action |
| ---- | ------ |
| `SUPER + /` | Random background image |
| `SUPER + ,` | Previous image |
| `SUPER + .` | Next image |
| `SUPER_REV + /` | Fuzzy-select image |
| `SUPER + b` | Toggle focus mode (solid color, no image) |

## Font

| Keys | Action |
| ---- | ------ |
| `SUPER_REV + r` | Reset font size to default |

### Resize Font Table (Leader Sequence)

| Keys | Action |
| ---- | ------ |
| `LEADER f` | Enter resize font mode (2s timeout) |
| `k` / `j` | Increase / decrease font size |
| `r` | Reset font size |
| `q` / `Esc` | Exit mode |

### Resize Pane Table (Leader Sequence)

| Keys | Action |
| ---- | ------ |
| `LEADER p` | Enter resize pane mode (2s timeout) |
| `k/j/h/l` | Grow pane Up/Down/Left/Right (1 cell) |
| `q` / `Esc` | Exit mode |

## Mouse

| Action | Behavior |
| ------ | ------ |
| Select text | Auto-copies to clipboard (default mouse binding) |
| `Ctrl + Click` | Open link under cursor |
| Right-click `+` button | Fuzzy launch selector with profile icons |

## Notes

- Default key bindings are disabled; only shortcuts listed here are active.
- Default mouse bindings are **not** disabled; copy-on-select and other mouse behaviors work normally.
- The `SUPER` modifier can be overridden via the `WEZTERM_SUPER_KEY` environment variable.
