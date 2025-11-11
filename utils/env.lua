local M = {}

---Get an environment variable or a default value
---@param name string
---@param default any
---@return string|any
function M.get(name, default)
   local value = os.getenv(name)
   if value == nil or value == '' then
      return default
   end
   return value
end

---Return an environment variable parsed as boolean
---@param name string
---@param default boolean
---@return boolean
function M.bool(name, default)
   local value = os.getenv(name)
   if value == nil or value == '' then
      return default
   end
   value = value:lower()
   if value == '1' or value == 'true' or value == 'yes' or value == 'on' then
      return true
   end
   if value == '0' or value == 'false' or value == 'no' or value == 'off' then
      return false
   end
   return default
end

---Return an environment variable parsed as number
---@param name string
---@param default number
---@return number
function M.number(name, default)
   local value = tonumber(os.getenv(name) or '')
   if value == nil then
      return default
   end
   return value
end

return M
