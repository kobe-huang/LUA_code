--[[base.lua
为指定对象定义元表

Exported API:
	define(class, table)
	string.startsWith(value, prefix, toffset)
	string.endsWith(value, suffix)
	string.title(value)
	table.copy(source, destiny, overlay)
	table.clear(tab)
	table.removeValue(value)
	table.removeKey(key)
	table.size(tab)
	table.iterator(tab)
	table.contains(tab, object)
	table.isArray(tab)
	table.isMap(tab)
	toString()
Example:
--]]

--------------------------------------------------------------------------------
function define(class, object)
	return setmetatable(object or {}, class)
end
--------------------------------------------------------------------------------
function toNumber(value, default)
	local ret = tonumber(value)
	return ret and ret or (default or 0)
end
--------------------------------------------------------------------------------
function string.startsWith(value, prefix, toffset)
	if value and prefix then
		toffset = (toffset or 1) > 0 and toffset or 1
		return string.sub(value, toffset, toffset + #prefix - 1) == prefix
	end
	return false
end
--------------------------------------------------------------------------------
function string.endsWith(value, suffix)
	if value and suffix then
		return string.sub(value, -#suffix) == suffix
	end
	return false
end
--------------------------------------------------------------------------------
function string.title(value)
	return string.upper(string.sub(value, 1, 1)) .. string.sub(value, 2, #value)
end
--------------------------------------------------------------------------------
function string.little(value)
	return string.lower(string.sub(value, 1, 1)) .. string.sub(value, 2, #value)
end
--------------------------------------------------------------------------------
function string.charAt(value, position)
	if value and position and position > 0 then
		local b = string.byte(value, position, position + 1)
		return b and string.char(b) or b
	end
end
--------------------------------------------------------------------------------
function string.isWhitespace(value)
	if value then
		local len = #value
		for i = 1, len do
			local char = string.charAt(value, i)
			if char ~= " " and char ~= "\t" then
				return false
			end
		end
		return true
	end
	return false
end
--------------------------------------------------------------------------------
function string.toArray(value)
	local ret = {}
	if value then
		local idx = 1
		local count = #value
		while idx <= count do
			local b = string.byte(value, idx, idx + 1)
			if b > 127 then
				table.insert(ret, string.sub(value, idx, idx + 1))
				idx = idx + 2
			else
				table.insert(ret, string.char(b))
				idx = idx + 1
			end
		end
	end
	return ret
end
--------------------------------------------------------------------------------
function table.copy(source, destiny, overlay)
	if source then
		overlay = overlay ~= false
		if not destiny then destiny = {} end
		for field, value in pairs(source) do
			if overlay then
				destiny[field] = value
			elseif not destiny[field] then
				destiny[field] = value
			end
		end
	end
	return destiny
end
--------------------------------------------------------------------------------
function table.deepCopy(srcTable,dstTable)
	local dst=dstTable or {}
	if (type(srcTable)=="table" and type(dst)=="table") then
		for key,value in pairs(srcTable) do
			if (type(value)=="table") then
				dst[key]=table.deepCopy(value)
			else
				dst[key]=value
			end
		end
	end
	return dst
end
--------------------------------------------------------------------------------
function table.join(...)
	local ret = {}
	for i = 1, select("#", ...) do
		local tb = select(i, ...)
		for _, value in pairs(tb or {}) do
			table.insert(ret, value)
		end
	end
	return ret
end
--------------------------------------------------------------------------------
function table.clear(tab)
	if tab then
		local field = next(tab)
		while field do
			tab[field] = nil
			field = next(tab)
		end
	end
	return tab
end
--------------------------------------------------------------------------------
function table.removeValue(tab, value)
	if tab then
		if table.isArray(tab) then
			local idx = 1
			for k, v in pairs(tab) do
				if v == value then
					table.remove(tab, idx)
					break
				end
				idx = idx + 1
			end
		else
			for k, v in pairs(tab) do
				if v == value then
					tab[k] = nil
					break
				end
			end
		end
	end
	return tab
end
--------------------------------------------------------------------------------
function table.removeKey(tab, key)
	if tab then
		for k, v in pairs(tab) do
			if k == key then
				tab[k] = nil
				break
			end
		end
	end
	return tab
end
--------------------------------------------------------------------------------
function table.size(tab)
	local size = 0
	if tab then
		table.foreach(tab, function()
			size = size + 1
		end)
	end
	return size
end
--------------------------------------------------------------------------------
local empty_fun = function() end
function table.iterator(tab)
	if tab then
		local index = 0
		local auxTable = {}
		table.foreach(tab, function(i, v)
			if (tonumber(i) ~= i) then
				table.insert(auxTable, i)
			else
				table.insert(auxTable, tostring(i))
			end
		end)

		return function()
			if index < #auxTable then
				index = index + 1
				local field = auxTable[index]
				local n = tonumber(field)
				if n and n > 0 then
					return n, tab[n]
				else
					return field, tab[field]
				end
			end
		end
	else
		return empty_fun
	end
end
--------------------------------------------------------------------------------
function table.contains(tab, object)
	if tab and object then
		for field, value in pairs(tab) do
			if object == value then return true end
		end
	end
	return false
end
--------------------------------------------------------------------------------
function table.isArray(tab)
	if not tab then
		return false
	end

	local ret = true
	local idx = 1
	for f, v in pairs(tab) do
		if type(f) == "number" then
			if f ~= idx then
				ret = false
			end
		else
			ret = false
		end
		if not ret then break end
		idx = idx + 1
	end
	return ret
end
--------------------------------------------------------------------------------
function table.isMap(tab)
	if not tab then
		return false
	end
	return table.isArray(tab) ~= true
end
---------------------------------------------------------------------------------
function toString(value, default)
	local str = ""
	if type(value) ~= "table" then
		if type(value) == "string" then
			str = str .. string.format("%q", value)
		elseif value == nil then
			str = str .. tostring(default)
		else
			str = str .. tostring(value)
		end
	else
		str = str .. '{'
		local separator = ""
		if table.isArray(value) then
			table.foreach(value, function (i, v)
				str = str .. separator .. string.format("%s", toString(v))
				separator = ", "
			end)
		else
			table.foreach(value, function (f, v)
				if type(f) == "number" then
					str = str .. separator .. string.format("[%d] = %s", f, toString(v))
				else
					str = str .. separator .. string.format("%s = %s", tostring(f), toString(v))
				end
				separator = ", "
			end)
		end
		str = str .. '}'
	end
	return tostring(str)
end
-----------------------------------------------------------------
function color2hex(r, g, b)
	local r = (r or 0xFF) * 0x10000
	local g = (g or 0xFF) * 0x100
	local b = b or 0xFF
	return r + g + b
end
-----------------------------------------------------------------
function color2hexstr(r,g,b)
	local hex = color2hex(r, g, b)
	return string.format("0x%.6x", hex)
end
-----------------------------------------------------------------
function hex2color(hex)
	local r = math.floor(hex / 0x10000)
	local g = math.floor((hex % 0x10000) / 0x100)
	local b = math.floor(hex % 0x100)
	return r, g, b
end