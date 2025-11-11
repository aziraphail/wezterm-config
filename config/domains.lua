local platform = require('utils.platform')
local env = require('utils.env')

local options = {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   ssh_domains = {},

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {},
}

local function split_list(value)
   local items = {}
   for item in value:gmatch('([^,]+)') do
      local trimmed = item:gsub('^%s+', ''):gsub('%s+$', '')
      if #trimmed > 0 then
         table.insert(items, trimmed)
      end
   end
   return items
end

local function default_distros()
   local override = env.get('WEZTERM_WSL_DISTROS')
   if override then
      local parsed = split_list(override)
      if #parsed > 0 then
         return parsed
      end
   end
   return { 'Ubuntu', 'archlinux' }
end

local function make_wsl_domain(name, distribution, username, shell, cwd)
   return {
      name = name,
      distribution = distribution,
      username = username,
      default_cwd = cwd,
      default_prog = { shell, '-l' },
   }
end

if platform.is_win and env.bool('WEZTERM_ENABLE_WSL', true) then
   local username = env.get('WEZTERM_WSL_USER', 'suhail')
   if not username or username == '' then
      username = os.getenv('WSL_USERNAME') or os.getenv('USERNAME') or 'root'
   end
   local home = env.get('WEZTERM_WSL_HOME', string.format('/home/%s', username))

   for _, distribution in ipairs(default_distros()) do
      table.insert(
         options.wsl_domains,
         make_wsl_domain(
            string.format('wsl:%s-%s', distribution:lower(), 'bash'),
            distribution,
            username,
            'bash',
            home
         )
      )
   end
end

local ssh_remote = env.get('WEZTERM_SSH_REMOTE')

if ssh_remote then
   local ssh_name = env.get('WEZTERM_SSH_DOMAIN_NAME', 'ssh:remote')
   table.insert(options.ssh_domains, {
      name = ssh_name,
      remote_address = ssh_remote,
      multiplexing = env.get('WEZTERM_SSH_MULTIPLEXING', 'None'),
      assume_shell = env.get('WEZTERM_SSH_ASSUME_SHELL', 'Posix'),
   })
end

return options
