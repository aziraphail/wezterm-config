# Vertical Tabs in WezTerm — Research Notes

## Status: Not yet implemented. Revisit after config refactoring is complete.

## Native Support

WezTerm has **no built-in vertical tab bar**. Tab bar can only go top or bottom.

- **Issue #3537** — "Allow the tab bar to be rendered on the side" (opened Apr 2023, still open)
- **PR #7574** — "Add vertical tab bar support (Left/Right positioning)" (opened Feb 2026, unmerged, no maintainer review). Adds `tab_bar_position` config with `"Top"`, `"Bottom"`, `"Left"`, `"Right"` values and `tab_bar_width` (default `"200px"`). 859 additions across 17 files.

## Workaround: Sidebar Pane + TUI

The most viable approach today. The idea:

1. Hide the native tab bar (`enable_tab_bar = false` or `show_tabs_in_tab_bar = false`)
2. Auto-spawn a narrow left pane in every window
3. Run a TUI in that pane that reads `wezterm cli list --format json`
4. Renders tabs vertically; selecting one calls `wezterm cli activate-tab --tab-id <id>`

### Key WezTerm APIs

- `pane:split{ direction = "Left", size = 0.15 }` — create narrow left pane
- `wezterm cli list --format json` — returns window_id, tab_id, pane_id, workspace, title, cwd
- `wezterm cli activate-tab --tab-id <id>` — switch tabs programmatically
- `show_tabs_in_tab_bar = false` + `show_new_tab_button_in_tab_bar = false` — hide native tabs while keeping status areas

### Limitations

- Sidebar pane can be resized, closed, or accidentally focused
- No way to lock pane width or make it non-closeable via the API

## Existing Projects

### wezterm-agent-cards (https://github.com/wrock/wezterm-agent-cards)
- Lua module + Python curses TUI
- Shows each tab as a "card" with project name and last output line
- Cards change color based on Claude Code status
- Auto-spawns sidebar via WezTerm events

### wez-sidebar (https://github.com/kok1eee/wez-sidebar)
- Rust-based TUI running in a WezTerm pane
- Reads session data via `wezterm cli list` and `wezterm cli get-text`
- Monitors Claude Code session status, git branch
- Zero-polling architecture
- Pre-built binaries for macOS and Linux

### claude-pad (https://github.com/nohzafk/claude-pad)
- Controller pad in a bottom split pane
- Queues instructions and sends commands to Claude Code sessions

## Other Approaches (Less Viable)

- **Status bar hack** — Use `update-right-status` with `\n` to render tab list. Still lives in horizontal bar strip, not a true sidebar.
- **ShowTabNavigator** — Built-in popup with tab thumbnails. Not persistent but useful for quick switching. Bind with: `{ key = 'Tab', mods = 'ALT', action = act.ShowTabNavigator }`
- **Build WezTerm from PR #7574** — Would give native vertical tabs but requires building from source.

## Inspiration: cmux

cmux (macOS-only terminal) has the gold standard vertical tabs:
- Left sidebar showing all workspaces as vertical tabs
- Each tab displays: git branch, PR status, working directory, listening ports, latest notification
- Notification rings when agents need attention
- Built on libghostty for GPU-accelerated rendering

## Decision

To be made after current config refactoring is complete. Options:
- A) Integrate an existing project (wez-sidebar or wezterm-agent-cards)
- B) Build a minimal custom version
- C) Wait for PR #7574 to merge
