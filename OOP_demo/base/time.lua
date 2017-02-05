--time.lua
--time功能函数集合:目前仅支持format: t="2009-05-15 09:10:44"

time = {}
function time.year(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>4) then
		return tonumber(string.sub(timeStr,1,4))
	end
end

function time.month(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>7) then
		return tonumber(string.sub(timeStr,6,7))
	end
end

function time.day(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>10) then
		return tonumber(string.sub(timeStr,9,10))
	end
end

function time.hour(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>13) then
		return tonumber(string.sub(timeStr,12,13))
	end
end

function time.min(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>16) then
		return tonumber(string.sub(timeStr,15,16))
	end
end

function time.sec(timeStr)
	if (type(timeStr)=="string" and string.len(timeStr)>=19) then
		return tonumber(string.sub(timeStr,18,19))
	end
end

--(format :"2009-05-15 09:10:44")字符串转换为lua time
function time.totime(timeStr)
	local y=time.year(timeStr)
	local m=time.month(timeStr)
	local d=time.day(timeStr)
	local h=time.hour(timeStr)
	local min=time.min(timeStr)
	local sec=time.sec(timeStr)
	if (y and m and d and h and min and sec) then
		local ttime={year=y,month=m,day=d,hour=h,
		min=min,sec=sec}
		return os.time(ttime)
	end
end

--lua time转换为字符串(format :"2009-05-15 09:10:44")
function time.tostring(lua_time)
	local t=os.date("*t",lua_time)
	if (type(t)=="table" and table.size(t)==9) then
		return t["year"].."-"..t["month"].."-"..t["day"].." "..t["hour"]..":"..t["min"]..":"..t["sec"]
	end
end