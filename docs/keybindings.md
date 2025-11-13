# Key Bindings Reference

This config disables WezTerm's built-in key bindings (`disable_default_key_bindings = true`), so **every active shortcut is defined in `config/bindings.lua`**. Copy/paste (`Ctrl+Shift+C/V`) and mouse link opening are re-added explicitly. Anything not listed here is unbound unless you provide your own overrides.

## Modifier Legend

| Symbol | Windows / Linux | macOS |
| ------ | ---------------- | ------ |
| `SUPER` | `ALT` | `⌘ (Command)` |
| `SUPER_REV` | `ALT + CTRL` | `⌘ + CTRL` |
| `LEADER` | Press `SUPER_REV` then `Space` | Same |

## Misc / Global

| Keys | Action |
| ---- | ------ |
| `F1` | Activate copy mode |
| `F2` | Command palette |
| `F3` | Launcher |
| `F4` | Fuzzy tab launcher |
| `F5` | Fuzzy workspace launcher |
| `F11` | Toggle fullscreen |
| `F12` | Debug overlay |
| `SUPER + f` | Search (case-insensitive) |
| `SUPER_REV + u` | QuickSelect URLs → open via default handler |
| `SUPER + Left/Right` | Send Home/End (terminal-level) |
| `SUPER + Backspace` | Delete line backwards (Ctrl+U) |
| `Ctrl+Shift+C` | Copy to clipboard |
| `Ctrl+Shift+V` | Paste from clipboard |
| `Ctrl + Click` | Open link at mouse cursor |

## Tabs & Windows

| Keys | Action |
| ---- | ------ |
| `SUPER + t` | New tab (default domain) |
| `SUPER_REV + t` | New tab (first WSL domain if available, else default) |
| `SUPER_REV + w` | Close current tab (no prompt) |
| `SUPER + [` / `SUPER + ]` | Previous / next tab |
| `SUPER_REV + [` / `SUPER_REV + ]` | Move tab left / right |
| `SUPER + 0` | Rename current tab (prompt) |
| `SUPER_REV + 0` | Reset tab title |
| `SUPER + 9` | Toggle tab bar visibility |
| `SUPER + n` | Spawn window |
| `SUPER + -` / `SUPER + =` | Shrink / grow window (±50 px, ignored in fullscreen) |
| `SUPER_REV + Enter` | Maximize window |

## Panes

| Keys | Action |
| ---- | ------ |
| `SUPER + \` | Split vertically (current pane domain) |
| `SUPER_REV + \` | Split horizontally |
| `SUPER + Enter` | Toggle pane zoom |
| `SUPER + w` | Close current pane |
| `SUPER_REV + k/j/h/l` | Move focus Up/Down/Left/Right |
| `SUPER_REV + p` | Pane select (swap with active and keep focus) |
| `SUPER + u/d` | Scroll up/down 5 lines |
| `PageUp/PageDown` | Scroll ±0.75 page |

## Background Controls

| Keys | Action |
| ---- | ------ |
| `SUPER + /` | Randomize background image |
| `SUPER + ,` | Previous image |
| `SUPER + .` | Next image |
| `SUPER_REV + /` | Fuzzy-select image (InputSelector) |
| `SUPER + b` | Toggle focus mode (solid color) |

## Key Tables (Leader Sequences)

Activate the leader by pressing `SUPER_REV + Space`, then follow with one of the sequences below. Each table stays active until you exit with `Esc` or `q`.

### Resize Font Table

| Keys | Action |
| ---- | ------ |
| `LEADER f` | Enter table |
| `k` | Increase font size |
| `j` | Decrease font size |
| `r` | Reset font size |
| `q` / `Esc` | Exit table |

### Resize Pane Table

| Keys | Action |
| ---- | ------ |
| `LEADER p` | Enter table |
| `k/j/h/l` | Grow pane Up/Down/Left/Right (1 cell per keypress) |
| `q` / `Esc` | Exit table |

## Notes on Defaults

- Because defaults are disabled, standard shortcuts like `Ctrl+Tab` or `Cmd+Shift+]` **do not exist** unless you add them manually.
- Copy/paste and mouse bindings were manually reintroduced (see Misc table).
- Feel free to append additional bindings in `config/bindings.lua`—the helper tables (`mod`, `keys`, `key_tables`) are easy to extend.
