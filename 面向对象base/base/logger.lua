--logger.lua
--logger功能支持
require "base.class"

LOG_LEVEL = {
	OFF = 100,	-- 关闭所有消息输出
	ALL = 0,	-- 允许所有等级消息输出
	INFO = 1,	-- 用于跟踪程序运行进度
	DEBUG = 2,	-- 用于调试消息的输出
	WARN = 3,	-- 程序运行时发生异常
	ERROR = 4,	-- 程序运行时发生可预料的错误,此时通过错误处理,可以让程序恢复正常运行
}

Logger = own_class(nil, Singleton)
function Logger:__init()
	self.level = LOG_LEVEL.INFO
end

--关闭logger
function Logger:disable()
	self.level = LOG_LEVEL.OFF
end

--设置logger等级
function Logger:setLevel(lvl)
	if table.contains(LOG_LEVEL, lvl) then
		self.level = lvl
	end	
end

--INFO
function Logger:info(fmt, ...)
	if self.level <= LOG_LEVEL.INFO then
		fmt = string.format("[INFO]: %s", fmt)
		print(string.format(fmt, ...))
	end
end

--DEBUG
function Logger:debug(fmt, ...)
	if self.level <= LOG_LEVEL.DEBUG then
		fmt = string.format("[DEBUG]: %s", fmt)
		print(string.format(fmt, ...))
	end
end

--WARN
function Logger:warn(fmt, ...)
	if self.level <= LOG_LEVEL.WARN then
		fmt = string.format("[WARNING]: %s", fmt)
		print(string.format(fmt, ...))
	end
end

--ERROR
function Logger:error(fmt, ...)
	if self.level <= LOG_LEVEL.ERROR then
		fmt = string.format("[ERROR]: %s", fmt)
		print(string.format(fmt, ...))
	end
end

function Logger.getInstance()
	return Logger()
end

g_logger = Logger.getInstance()
