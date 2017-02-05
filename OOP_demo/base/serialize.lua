--[[serialize.lua
声明序列化接口,并提供serialize和unserialize函数用于对Table对象进行序列化和反序列化操作

Exported API:

Example:
--]]

require "base.interface"

Serializable = interface(nil,
	"writeObject",
	"readObject")

--------------------------------------------------------------------------------
--序列化一个Table
function serialize(t)
	local mark={}
	local assign={}

	local function table2str(t, parent)
		mark[t] = parent
		local ret = {}

		if table.isArray(t) then
			table.foreach(t, function(i, v)
				local k = tostring(i)
				local dotkey = parent.."["..k.."]"
				local t = type(v)
				if t == "userdata" or t == "function" or t == "thread" or t == "proto" or t == "upval" then
					--ignore
				elseif t == "table" then
					if mark[v] then
						table.insert(assign, dotkey.."="..mark[v])
					else
						table.insert(ret, table2str(v, dotkey))
					end
				elseif t == "string" then
					table.insert(ret, string.format("%q", v))
				elseif t == "number" then
					if v == math.huge then
						table.insert(ret, "math.huge")
					elseif v == -math.huge then
						table.insert(ret, "-math.huge")
					else
						table.insert(ret,  tostring(v))
					end
				else
					table.insert(ret,  tostring(v))
				end
			end)
		else
			table.foreach(t, function(f, v)
				local k = type(f)=="number" and "["..f.."]" or f
				local dotkey = parent..(type(f)=="number" and k or "."..k)
				local t = type(v)
				if t == "userdata" or t == "function" or t == "thread" or t == "proto" or t == "upval" then
					--ignore
				elseif t == "table" then
					if mark[v] then
						table.insert(assign, dotkey.."="..mark[v])
					else
						table.insert(ret, string.format("%s=%s", k, table2str(v, dotkey)))
					end
				elseif t == "string" then
					table.insert(ret, string.format("%s=%q", k, v))
				elseif t == "number" then
					if v == math.huge then
						table.insert(ret, string.format("%s=%s", k, "math.huge"))
					elseif v == -math.huge then
						table.insert(ret, string.format("%s=%s", k, "-math.huge"))
					else
						table.insert(ret, string.format("%s=%s", k, tostring(v)))
					end
				else
					table.insert(ret, string.format("%s=%s", k, tostring(v)))
				end
			end)
		end

		return "{"..table.concat(ret,",").."}"
	end

	if type(t) == "table" then
		return string.format("%s%s",  table2str(t,"_"), table.concat(assign," "))
	else
		return tostring(t)
	end
end

local EMPTY_TABLE = {}
--------------------------------------------------------------------------------
--反序列化一个Table
function unserialize(str)
	if str == nil then
		str = tostring(str)
	elseif type(str) ~= "string" then
		EMPTY_TABLE = {}
		return EMPTY_TABLE
	elseif #str == 0 then
		EMPTY_TABLE = {}
		return EMPTY_TABLE
	end

	local code, ret = pcall(loadstring(string.format("do local _=%s return _ end", str)))

	if code then
		return ret
	else
		EMPTY_TABLE = {}
		return EMPTY_TABLE
	end
end

function readRecords(buff)
	local records = {}
	local recordcnt = buff:popShort()
	for idx = 1, recordcnt do		
		local attrcnt = buff:popChar()
		if attrcnt > 0 then
			local record = {}
			for idx = 1, attrcnt do
				local name = string.little(buff:popString())
				local type = buff:popChar()
				if type == 0 then --INT
					record[name] = buff:popInt()
				elseif type == 3 then --FLOAT
					record[name] = buff:popFloat()
				elseif type == 4 then --BOOL
					record[name] = buff:popBool()
				elseif type == 5 then --DOUBLE
					record[name] = buff:popDouble()
				elseif type == 6 then --LONGLONG
					record[name] = buff:popLongLong()
				else
					record[name] = buff:popString()
				end
			end
			records[idx] = record
		end		
	end
	return records
end

function readTableKV(buff)	
	local tab = {}
	local cnt = buff:popChar()				
	for idx = 1, cnt do
		local k = buff:popInt()
		tab[k] = buff:popInt()
	end
	return tab
end