# WezTerm Config Refactoring — Design Spec

**Date:** 2026-04-02
**Scope:** Keybinding improvements, feature additions, code simplification

## 1. Keybinding Changes (`config/bindings.lua`)

### Direct tab switching (`mod.SUPER` + 1-9)
All tab-switching bindings use `mod.SUPER` (Alt on Windows/Linux, Cmd on Mac) for platform consistency.

- `mod.SUPER` + 1 through 8 → `ActivateTab(0)` through `ActivateTab(7)` (WezTerm uses 0-indexed tabs)
- `mod.SUPER` + 9 → `ActivateTab(-1)` (activates the last tab, matches Windows Terminal behavior)

### Relocated bindings
These move from `mod.SUPER` to `mod.SUPER_REV` (Alt+Ctrl on Windows/Linux, Cmd+Ctrl on Mac):
- `mod.SUPER` + 0 (tab title rename) → `mod.SUPER_REV` + 0
- `mod.SUPER` + 9 (toggle tab bar) → `mod.SUPER_REV` + 9

### Font reset shortcut
- `mod.SUPER_REV` + R → `ResetFontSize` (direct shortcut, no need to enter the resize_font key table)

## 2. General Config (`config/general.lua`)

### Copy-on-select
- Add `copy_on_select = true` — selecting text auto-copies to system clipboard

## 3. Battery Widget Cleanup (`events/right-status.lua`)

**Problem:** On desktop PCs, `wezterm.battery_info()` returns an empty table, leaving a dangling separator and blank space in the status bar.

**Fix:** Check if battery info is available. If empty, render date only — skip the separator and battery segments. The `battery_info()` function call and rendering logic stays, it just conditionally includes the battery segments.

Render order becomes:
- With battery: `date_icon, date_text, separator, battery_icon, battery_text`
- Without battery: `date_icon, date_text`

## 4. Simplify GpuAdapters (`utils/gpu-adapter.lua`)

**Problem:** 134-line class with lookup tables, when the actual logic is a simple priority chain.

**Preserve:** The `Other → Gl` backend fallback (bugfix from commit `72ca4f7`). This is real — on some Windows machines, discrete GPUs appear under the `Other` device type with only the `Gl` backend.

**New implementation (~30 lines):**
- Keep pcall guard around `enumerate_gpus()`
- Walk GPUs in priority: DiscreteGpu > IntegratedGpu > Other > Cpu
- For each device type, prefer platform-specific backend (Dx12 on Windows, Vulkan on Linux, Metal on Mac)
- Special case: `Other` device type forces `Gl` backend
- Return matching adapter or nil (let WezTerm decide)
- Export the same interface: module returns a table with `pick_best()` so `appearance.lua` doesn't change
- Drop `pick_manual()` — only used in commented-out lines in `appearance.lua`
- Remove the commented-out `pick_manual()` examples from `config/appearance.lua`

## 5. Remove OptsValidator (`utils/opts-validator.lua`)

**Problem:** 178-line schema validation framework used in exactly 2 places to validate hardcoded options that never change.

**Replace with:** Simple inline defaults-merging at each call site.

### `events/right-status.lua`
Before:
```lua
local EVENT_OPTS = {}
EVENT_OPTS.schema = { { name = 'date_format', type = 'string', default = '%a %H:%M:%S' } }
EVENT_OPTS.validator = OptsValidator:new(EVENT_OPTS.schema)
-- ...
local valid_opts, err = EVENT_OPTS.validator:validate(opts or {})
```

After:
```lua
local defaults = { date_format = '%a %H:%M:%S' }
-- in setup():
opts = opts or {}
for k, v in pairs(defaults) do
   if opts[k] == nil then opts[k] = v end
end
```

### `events/tab-title.lua`
Same pattern for `unseen_icon` (default `'circle'`) and `hide_active_tab_unseen` (default `true`).

### Cleanup
- Delete `utils/opts-validator.lua`
- Remove all `require('utils.opts-validator')` references

## Files Changed

| File | Change |
|---|---|
| `config/bindings.lua` | Add Alt+1-9 tab switching, move Alt+0/9, add Alt+Ctrl+R font reset |
| `config/general.lua` | Add `copy_on_select = true` |
| `events/right-status.lua` | Conditional battery rendering, remove OptsValidator |
| `events/tab-title.lua` | Remove OptsValidator, inline defaults |
| `utils/gpu-adapter.lua` | Rewrite as simple function (~30 lines) |
| `utils/opts-validator.lua` | Delete |
| `config/appearance.lua` | Remove commented-out `pick_manual()` lines |
| `wezterm.lua` | Remove redundant `date_format` arg from `right-status.setup()` call |
| `README.md` | Update GPU adapter description to reflect simplification |

## Out of Scope

- Cells utility (`utils/cells.lua`) — deeply integrated across 4 event files, not worth the risk for no functional gain
- Vertical tabs sidebar — separate future project (see `docs/vertical-tabs-research.md`)
- Backdrop opacity / inactive pane dimming — user chose not to include these
