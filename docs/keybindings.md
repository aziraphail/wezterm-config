# Key Bindings Reference

This config disables WezTerm's built-in key bindings (`disable_default_key_bindings = true`). Default mouse bindings remain active (copy-on-select works out of the box).

Keybinding design follows Ghostty's conventions: **Ctrl+Shift** for primary actions (safe from shell conflicts), **Ctrl+Alt** for secondary actions, **Alt** for tab switching.

## Modifier Legend

| Symbol | Windows / Linux | macOS |
| ------ | ---------------- | ------ |
| `SUPER` | `Ctrl+Shift` | `Cmd` |
| `SUPER_REV` | `Ctrl+Alt` | `Cmd+Ctrl` |
| `LEADER` | `Ctrl+Alt+Space` (3s timeout) | `Cmd+Ctrl+Space` |

## Global / Misc

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+P | Command palette |
| Ctrl+Shift+F | Search (case-insensitive) |
| Ctrl+Shift+N | New window |
| Ctrl+Alt+U | QuickSelect URLs and open in browser |
| F1 | Activate copy mode |
| F2 | Command palette (alias) |
| F3 | Launcher |
| F4 | Fuzzy tab launcher |
| F5 | Fuzzy workspace launcher |
| F11 | Toggle fullscreen |
| F12 | Debug overlay |

## Copy/Paste

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+C | Copy to clipboard |
| Ctrl+Shift+V | Paste from clipboard |
| Select text | Auto-copy (default mouse binding) |
| Ctrl+Click | Open link under cursor |

## Tabs

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+T | New tab (default domain) |
| Ctrl+Tab | Next tab |
| Ctrl+Shift+Tab | Previous tab |
| Ctrl+Shift+[ / ] | Previous / next tab (alternative) |
| Ctrl+Alt+[ / ] | Move tab left / right |
| Alt+1-8 | Switch to tab 1-8 |
| Alt+9 | Switch to last tab |
| Ctrl+Alt+W | Close tab (no confirm) |
| Ctrl+Alt+0 | Rename tab (prompt) |
| Ctrl+Alt+9 | Toggle tab bar visibility |
| Ctrl+Shift+L | Fuzzy launch selector (profiles with icons) |

## Panes

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+\ | Split vertically |
| Ctrl+Alt+\ | Split horizontally |
| Ctrl+Shift+Enter | Toggle pane zoom |
| Ctrl+Shift+W | Close current pane |
| Ctrl+Alt+H/J/K/L | Move pane focus Left/Down/Up/Right |
| Ctrl+Alt+P | Pane select (swap with active, keep focus) |
| Ctrl+Shift+U / D | Scroll up / down 5 lines |
| PageUp / PageDown | Scroll 0.75 page |

## Font Size

| Keys | Action |
| ---- | ------ |
| Ctrl+= | Increase font size |
| Ctrl+- | Decrease font size |
| Ctrl+0 | Reset font size |

## Window

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+- / = | Shrink / grow window (50px, ignored in fullscreen) |
| Ctrl+Alt+Enter | Maximize window |

## Background Controls

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+/ | Random background image |
| Ctrl+Shift+, / . | Cycle background images |
| Ctrl+Alt+/ | Fuzzy-select background image |
| Ctrl+Shift+B | Toggle focus mode (solid color, no image) |

## Cursor Movement (shell pass-through)

| Keys | Action |
| ---- | ------ |
| Alt+Left | Home (beginning of line) |
| Alt+Right | End (end of line) |
| Alt+Backspace | Delete line backwards |

## Leader Key Sequences

Activate the leader by pressing **Ctrl+Alt+Space** (3 second timeout), then press the key below. Key tables auto-exit after 2 seconds of inactivity, or press Escape/q.

### Resize Font Mode (Leader then f)

| Keys | Action |
| ---- | ------ |
| k / j | Increase / decrease font size |
| r | Reset font size |
| Escape / q | Exit mode |

### Resize Pane Mode (Leader then p)

| Keys | Action |
| ---- | ------ |
| k / j / h / l | Grow pane Up / Down / Left / Right (1 cell) |
| Escape / q | Exit mode |

## Mouse

| Action | Behavior |
| ------ | ------ |
| Select text | Auto-copies to clipboard |
| Ctrl+Click | Open link under cursor |
| Right-click + button | Fuzzy launch selector with profile icons |

## Notes

- Default key bindings are disabled; only shortcuts listed here are active.
- Default mouse bindings are **not** disabled; copy-on-select and other mouse behaviors work normally.
- The `SUPER` modifier can be overridden via the `WEZTERM_SUPER_KEY` environment variable.
- Ctrl+Shift is used as the primary modifier because terminal apps cannot distinguish Ctrl+Shift+key from Ctrl+key, making it a safe namespace that never conflicts with shell shortcuts.
