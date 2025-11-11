local wezterm = require('wezterm')
local Config = require('config')
local env = require('utils.env')
local backdrops = require('utils.backdrops')

local backdrop_dir = env.get('WEZTERM_BACKDROP_DIR')
if backdrop_dir then
   backdrops:set_images_dir(backdrop_dir)
end

local focus_color = env.get('WEZTERM_FOCUS_COLOR')
if focus_color then
   backdrops:set_focus(focus_color)
end

backdrops:set_images()

if not env.bool('WEZTERM_DISABLE_RANDOM_BACKDROP', false) then
   backdrops:random()
end

require('events.left-status').setup()
require('events.right-status').setup({ date_format = '%a %H:%M:%S' })
require('events.tab-title').setup({ hide_active_tab_unseen = false, unseen_icon = 'numbered_box' })
require('events.new-tab-button').setup()
require('events.gui-startup').setup()

return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options
