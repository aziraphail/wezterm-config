local wezterm = require('wezterm')
local platform = require('utils.platform')
local env = require('utils.env')

local default_font = env.get('WEZTERM_FONT', 'FiraCode Nerd Font')
local fallback_font = env.get('WEZTERM_FONT_FALLBACK', 'JetBrainsMono Nerd Font')

local font_definitions = {
   {
      family = default_font,
      weight = 'Medium',
   },
   {
      family = fallback_font,
   },
}

local function default_font_size()
   local font_size_override = env.number('WEZTERM_FONT_SIZE')
   if font_size_override then
      return font_size_override
   end
   if platform.is_mac then
      return 12
   elseif platform.is_win then
      return 10.5
   end
   return 10
end

return {
   font = wezterm.font_with_fallback(font_definitions),
   font_size = default_font_size(),

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
