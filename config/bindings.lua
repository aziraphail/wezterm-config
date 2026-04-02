local wezterm = require('wezterm')
local platform = require('utils.platform')
local env = require('utils.env')
local backdrops = require('utils.backdrops')
local new_tab_button = require('events.new-tab-button')
local act = wezterm.action

local mod = {}

local custom_super = env.get('WEZTERM_SUPER_KEY')
if custom_super then
   mod.SUPER = custom_super
   mod.SUPER_REV = custom_super .. '|CTRL'
elseif platform.is_mac then
   mod.SUPER = 'SUPER'
   mod.SUPER_REV = 'SUPER|CTRL'
else
   mod.SUPER = 'CTRL|SHIFT' -- matches Ghostty/Kitty convention; safe from shell conflicts
   mod.SUPER_REV = 'CTRL|ALT'
end


-- stylua: ignore
local keys = {
   -- misc/useful --
   { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
   { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
   { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
   { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
   {
      key = 'F5',
      mods = 'NONE',
      action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
   },
   { key = 'F11', mods = 'NONE',    action = act.ToggleFullScreen },
   { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },
   { key = 'f',   mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = '' }) },
   {
      key = 'u',
      mods = mod.SUPER_REV,
      action = wezterm.action.QuickSelectArgs({
         label = 'open url',
         patterns = {
            '\\((https?://\\S+)\\)',
            '\\[(https?://\\S+)\\]',
            '\\{(https?://\\S+)\\}',
            '<(https?://\\S+)>',
            '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'
         },
         action = wezterm.action_callback(function(window, pane)
            local url = window:get_selection_text_for_pane(pane)
            wezterm.log_info('opening: ' .. url)
            wezterm.open_with(url)
         end),
      }),
   },

   -- cursor movement (shell pass-through, hardcoded to Alt) --
   { key = 'LeftArrow',  mods = 'ALT',         action = act.SendString '\u{1b}OH' },
   { key = 'RightArrow', mods = 'ALT',         action = act.SendString '\u{1b}OF' },
   { key = 'Backspace',  mods = 'ALT',         action = act.SendString '\u{15}' },

   -- copy/paste --
   { key = 'c',          mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
   { key = 'v',          mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },

   -- tabs --
   -- tabs: spawn+close
   { key = 't',          mods = mod.SUPER,     action = act.SpawnTab('DefaultDomain') },
   {
      key = 'l',
      mods = mod.SUPER,
      action = act.InputSelector({
         title = 'InputSelector: Launch Menu',
         choices = new_tab_button.choices,
         fuzzy = true,
         fuzzy_description = wezterm.nerdfonts.md_rocket .. ' Select a launch item: ',
         action = wezterm.action_callback(function(window, pane, id, label)
            if not id and not label then
               return
            end
            window:perform_action(
               act.SpawnCommandInNewTab(new_tab_button.choices_data[tonumber(id)]),
               pane
            )
         end),
      }),
   },
   { key = 'w',          mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

   -- tabs: navigation (Ctrl+Tab/Ctrl+Shift+Tab added below via table.insert)
   { key = 'PageUp',    mods = 'CTRL',        action = act.MoveTabRelative(-1) },
   { key = 'PageDown',  mods = 'CTRL',        action = act.MoveTabRelative(1) },

   -- tab: title
   { key = '0',          mods = mod.SUPER_REV, action = act.EmitEvent('tabs.manual-update-tab-title') },

   -- tab: hide tab-bar
   { key = '9',          mods = mod.SUPER_REV, action = act.EmitEvent('tabs.toggle-tab-bar'), },

   -- window --
   -- window: spawn windows
   { key = 'n',          mods = mod.SUPER,     action = act.SpawnWindow },

   -- window: maximize
   {
      key = 'Enter',
      mods = mod.SUPER_REV,
      action = wezterm.action_callback(function(window, _pane)
         window:maximize()
      end)
   },

   -- background: toggle focus mode (letter key, works with Ctrl+Shift)
   {
      key = 'b',
      mods = mod.SUPER,
      action = wezterm.action_callback(function(window, _pane)
         backdrops:toggle_focus(window)
      end)
   },

   -- panes --
   -- panes: split (letter keys to avoid Ctrl+Shift+symbol issues)
   { key = 'd',     mods = mod.SUPER,     action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
   { key = 'd',     mods = mod.SUPER_REV, action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },

   -- panes: zoom+close pane
   { key = 'Enter', mods = mod.SUPER,     action = act.TogglePaneZoomState },
   { key = 'w',     mods = mod.SUPER,     action = act.CloseCurrentPane({ confirm = false }) },

   -- panes: navigation (arrow keys to avoid Ctrl+Alt+letter conflicts with system apps)
   { key = 'UpArrow',    mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
   { key = 'DownArrow',  mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
   { key = 'LeftArrow',  mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
   { key = 'RightArrow', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },
   {
      key = 'p',
      mods = mod.SUPER_REV,
      action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
   },

   -- panes: scroll pane
   { key = 'PageUp',   mods = 'SHIFT',   action = act.ScrollByPage(-1) },
   { key = 'PageDown', mods = 'SHIFT',   action = act.ScrollByPage(1) },

   -- key-tables --
   -- resizes fonts
   {
      key = 'f',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
         name = 'resize_font',
         one_shot = false,
         timeout_milliseconds = 2000,
      }),
   },
   -- resize panes
   {
      key = 'p',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
         name = 'resize_pane',
         one_shot = false,
         timeout_milliseconds = 2000,
      }),
   },

   -- font size (browser/Ghostty convention, hardcoded to Ctrl)
   { key = '=',     mods = 'CTRL',  action = act.IncreaseFontSize },
   { key = '-',     mods = 'CTRL',  action = act.DecreaseFontSize },
   { key = '0',     mods = 'CTRL',  action = act.ResetFontSize },
}

-- tab switching: Alt+1-8 for tabs, Alt+9 for last tab (matches Ghostty)
for i = 1, 8 do
   table.insert(keys, {
      key = tostring(i),
      mods = 'ALT',
      action = act.ActivateTab(i - 1),
   })
end
table.insert(keys, {
   key = '9',
   mods = 'ALT',
   action = act.ActivateTab(-1),
})

-- tab cycling (universal browser/terminal convention)
table.insert(keys, { key = 'Tab', mods = 'CTRL',       action = act.ActivateTabRelative(1) })
table.insert(keys, { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) })

-- command palette (matches Ghostty/VS Code/Windows Terminal)
table.insert(keys, { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette })

-- background controls (Leader key sequences)
table.insert(keys, {
   key = 'b',
   mods = 'LEADER',
   action = act.ActivateKeyTable({
      name = 'background',
      one_shot = true,
   }),
})

-- stylua: ignore
local key_tables = {
   background = {
      {
         key = 'r',
         action = wezterm.action_callback(function(window, _pane)
            backdrops:random(window)
         end),
      },
      {
         key = 'n',
         action = wezterm.action_callback(function(window, _pane)
            backdrops:cycle_forward(window)
         end),
      },
      {
         key = 'p',
         action = wezterm.action_callback(function(window, _pane)
            backdrops:cycle_back(window)
         end),
      },
      {
         key = 's',
         action = act.InputSelector({
            title = 'InputSelector: Select Background',
            choices = backdrops:choices(),
            fuzzy = true,
            fuzzy_description = 'Select Background: ',
            action = wezterm.action_callback(function(window, _pane, idx)
               if not idx then
                  return
               end
               ---@diagnostic disable-next-line: param-type-mismatch
               backdrops:set_img(window, tonumber(idx))
            end),
         }),
      },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
   resize_font = {
      { key = 'k',      action = act.IncreaseFontSize },
      { key = 'j',      action = act.DecreaseFontSize },
      { key = 'r',      action = act.ResetFontSize },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
   resize_pane = {
      { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
      { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
      { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
      { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
}

local mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
}

return {
   disable_default_key_bindings = true,
   -- disable_default_mouse_bindings = true,
   leader = { key = 'Space', mods = mod.SUPER_REV, timeout_milliseconds = 3000 },
   keys = keys,
   key_tables = key_tables,
   mouse_bindings = mouse_bindings,
}
