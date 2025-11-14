local wezterm = require('wezterm')
local env = require('utils.env')
local platform = require('utils.platform')
local domains = require('config.domains')

local options = {
   default_prog = {},
   launch_menu = {},
}

local function env_prog(var_name)
   local raw = env.get(var_name)
   if not raw then
      return nil
   end

   local ok, parsed = pcall(wezterm.shell_split, raw)
   if not ok then
      wezterm.log_error(('Unable to parse %s: %s'):format(var_name, parsed))
      return nil
   end
   return parsed
end

local function set_default_prog(fallback)
   options.default_prog = env_prog('WEZTERM_DEFAULT_PROG') or fallback or {}
end

local function set_default_domain(name)
   if name then
      options.default_domain = env.get('WEZTERM_DEFAULT_DOMAIN', name)
   end
end

local function add_launch_entry(tbl, label, args)
   if not args or #args == 0 then
      return
   end
   table.insert(tbl, { label = label, args = args })
end

if platform.is_win then
   set_default_prog({})
   local local_domain = { DomainName = 'local' }
   add_launch_entry(options.launch_menu, 'PowerShell (pwsh)', { 'pwsh', '-NoLogo' })
   options.launch_menu[#options.launch_menu].domain = local_domain
   add_launch_entry(options.launch_menu, 'PowerShell Desktop', { 'powershell' })
   options.launch_menu[#options.launch_menu].domain = local_domain
   add_launch_entry(options.launch_menu, 'Command Prompt', { 'cmd' })
   options.launch_menu[#options.launch_menu].domain = local_domain

   local git_bash = env.get('WEZTERM_GIT_BASH')
   if not git_bash then
      local candidate = wezterm.home_dir .. '\\scoop\\apps\\git\\current\\bin\\bash.exe'
      if wezterm.file_exists and wezterm.file_exists(candidate) then
         git_bash = candidate
      end
   end
   if git_bash then
      add_launch_entry(options.launch_menu, 'Git Bash', { git_bash, '-l' })
      options.launch_menu[#options.launch_menu].domain = local_domain
   end

   local nu = env.get('WEZTERM_NUSHELL_EXE') or 'nu'
   add_launch_entry(options.launch_menu, 'Nushell', { nu })
   options.launch_menu[#options.launch_menu].domain = local_domain

   if domains.wsl_domains and #domains.wsl_domains > 0 then
      set_default_domain(domains.wsl_domains[1].name)
   end
elseif platform.is_mac then
   set_default_prog({ '/bin/bash', '-l' })
   add_launch_entry(options.launch_menu, 'Bash', { '/bin/bash', '-l' })
   add_launch_entry(options.launch_menu, 'Zsh', { '/bin/zsh', '-l' })
   add_launch_entry(options.launch_menu, 'Fish', { '/opt/homebrew/bin/fish', '-l' })
   add_launch_entry(options.launch_menu, 'Nushell', { '/opt/homebrew/bin/nu', '-l' })
else -- linux and everything else unix-like
   set_default_prog({ '/bin/bash', '-l' })
   add_launch_entry(options.launch_menu, 'Bash', { '/bin/bash', '-l' })
   add_launch_entry(options.launch_menu, 'Fish', { 'fish', '-l' })
   add_launch_entry(options.launch_menu, 'Zsh', { 'zsh', '-l' })
   add_launch_entry(options.launch_menu, 'Nushell', { 'nu', '-l' })
end

local ok, overrides = pcall(require, 'config.launch_local')
if ok and type(overrides) == 'table' then
   if overrides.default_prog then
      options.default_prog = overrides.default_prog
   end
   if overrides.launch_menu then
      options.launch_menu = overrides.launch_menu
   end
end

return options
