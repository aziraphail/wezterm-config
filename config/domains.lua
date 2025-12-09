local wezterm = require 'wezterm'
local platform = require('utils.platform')
local env = require('utils.env')

local options = {
  ssh_domains = {},
  unix_domains = {},
  wsl_domains = {},
}

local function make_wsl_defaults()
  -- Figure out username
  local username = env.get('WEZTERM_WSL_USER', 'suhail')
  if not username or username == '' then
    username = os.getenv('WSL_USERNAME') or os.getenv('USERNAME') or 'root'
  end

  -- Figure out home dir inside WSL
  local home = env.get('WEZTERM_WSL_HOME', string.format('/home/%s', username))

  return username, home
end

local function reorder_wsl_domains(domains)
  if #domains == 0 then
    return domains
  end

  -- Comma-separated preference list; defaults to preferring Ubuntu when present.
  local raw_pref = env.get('WEZTERM_WSL_ORDER', 'Ubuntu')
  if not raw_pref or raw_pref == '' then
    return domains
  end

  local preferred = {}
  for name in raw_pref:gmatch('[^,]+') do
    local trimmed = name:match('^%s*(.-)%s*$')
    if trimmed ~= '' then
      table.insert(preferred, trimmed:lower())
    end
  end

  if #preferred == 0 then
    return domains
  end

  local ordered, used = {}, {}

  local function matches(dom, pref)
    local distro = (dom.distribution or dom.name):gsub('^WSL:', '')
    return distro:lower() == pref or dom.name:lower() == pref
  end

  for _, pref in ipairs(preferred) do
    for idx, dom in ipairs(domains) do
      if not used[idx] and matches(dom, pref) then
        table.insert(ordered, dom)
        used[idx] = true
      end
    end
  end

  for idx, dom in ipairs(domains) do
    if not used[idx] then
      table.insert(ordered, dom)
    end
  end

  return ordered
end

-- Auto-add ALL WSL distros
if platform.is_win and env.bool('WEZTERM_ENABLE_WSL', true) then
  local username, home = make_wsl_defaults()

  -- Let WezTerm discover distros
  for _, dom in ipairs(wezterm.default_wsl_domains()) do
    -- Optional: override bits to your liking
    dom.username = username
    dom.default_cwd = home
    dom.default_prog = { 'bash', '-l' }  -- or 'zsh', 'fish', etc

    table.insert(options.wsl_domains, dom)
  end

  options.wsl_domains = reorder_wsl_domains(options.wsl_domains)
end

-- SSH: only active if you set WEZTERM_SSH_REMOTE
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
