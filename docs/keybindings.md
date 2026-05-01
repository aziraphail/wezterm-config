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

## Tabs

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+T | New tab (default domain) |
| Ctrl+Tab | Next tab |
| Ctrl+Shift+Tab | Previous tab |
| Ctrl+PageUp / PageDown | Move tab left / right |
| Alt+1-8 | Switch to tab 1-8 |
| Alt+9 | Switch to last tab |
| Ctrl+Alt+0 | Rename tab (prompt) |
| Ctrl+Alt+9 | Toggle tab bar visibility |
| Ctrl+Shift+L | Fuzzy launch selector (profiles with icons) |

## Panes

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+D | Split right (new pane to the right) |
| Ctrl+Shift+E | Split down (new pane below) |
| Ctrl+Shift+Enter | Toggle pane zoom |
| Ctrl+Shift+W | Close surface: closes pane (if multiple panes), otherwise closes tab |
| Ctrl+Alt+Arrow keys | Move pane focus |
| Ctrl+Alt+P | Pane select (swap with active, keep focus) |
| Shift+PageUp / PageDown | Scroll full page |

## Font Size

| Keys | Action |
| ---- | ------ |
| Ctrl+= | Increase font size |
| Ctrl+- | Decrease font size |
| Ctrl+0 | Reset font size |

## Window

| Keys | Action |
| ---- | ------ |
| Ctrl+Alt+Enter | Maximize window |

## Cursor Movement (shell pass-through)

| Keys | Action |
| ---- | ------ |
| Alt+Left | Move cursor one word left |
| Alt+Right | Move cursor one word right |
| Alt+Backspace | Delete one word backwards |

## Leader Key Sequences

Activate the leader by pressing **Ctrl+Alt+Space** (3 second timeout), then press the key below.

### Background Mode (Leader then b, one-shot)

| Key | Action |
| --- | ------ |
| r | Random background image |
| n | Next background image |
| p | Previous background image |
| s | Fuzzy-select background image |
| Escape / q | Exit mode |

## Background Focus Mode

| Keys | Action |
| ---- | ------ |
| Ctrl+Shift+B | Toggle focus mode (solid color, no image) |

### Resize Font Mode (Leader then f, 2s timeout)

| Key | Action |
| --- | ------ |
| k / j | Increase / decrease font size |
| r | Reset font size |
| Escape / q | Exit mode |

### Resize Pane Mode (Leader then p, 2s timeout)

| Key | Action |
| --- | ------ |
| k / j / h / l | Grow pane Up / Down / Left / Right (1 cell) |
| Escape / q | Exit mode |

## Mouse

| Action | Behavior |
| ------ | ------ |
| Select text | Auto-copies to clipboard |
| Ctrl+Click | Open link under cursor |
| Right-click on new-tab (+) button | Fuzzy launch selector with profile icons |

## Notes

- Default key bindings are disabled; only shortcuts listed here are active.
- Default mouse bindings are **not** disabled; copy-on-select works normally.
- The `SUPER` modifier can be overridden via the `WEZTERM_SUPER_KEY` environment variable.
- Ctrl+Shift is used as the primary modifier because terminal apps cannot distinguish Ctrl+Shift+key from Ctrl+key, making it a safe namespace that never conflicts with shell shortcuts.
- Symbol keys ([ ] \ / , . - =) are avoided with Ctrl+Shift because Shift transforms them on Windows. Letter keys and special keys (Tab, Enter, Arrow, PageUp) are used instead.
- **Close surface** (Ctrl+Shift+W) matches Ghostty's `close_surface` action: if the tab has multiple panes, it closes the active pane; if only one pane remains, it closes the tab. No separate close-tab and close-pane bindings needed.
