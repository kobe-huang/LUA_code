--[[interface.lua
提供接口机制

Exported API:
	interface(super, ...)
	implemented(class, ...)
	isInterface(interface)
	isInterfaceInstance(object)
	superinterface(class)
	subinterfaceof(class, supe)

Example:
	Execute = interface(nil, "execute")
	Listener = interface(Execute, "getTarget", "execute")
	GroupListener = class(nil, Listener)
--]]

require "base.base"
--------------------------------------------------------------------------------
local interfaceMap = define { __mode = "k" }
local instanceMT = {}
local function dummy()
	print("Don't execute an interface method.")
end
--------------------------------------------------------------------------------
local function undefined(interface, method)
	if interface then
		return interface[method] == nil
	end
	return true
end
--------------------------------------------------------------------------------
local function iterator(interface)
	local methods = {}
	local index = 0
	while interface do
		for f, v in pairs(interface) do
			methods[#methods + 1] = f
		end
		interface = superinterface(interface)
	end
	function iter()
		local f, v
		if index < #methods then
			index = index + 1
			f, v = index, methods[index]
		end
		return f, v
	end
	return iter
end
--------------------------------------------------------------------------------
local function cast(interface, object)
	local class = classof(object)
	local ret, _ = implemented(class, interface)
	if ret then
		local instance = define(instanceMT)
		instance.__interface = interface
		for _, m in iterator(interface) do
			instance[m] = function(self, ...)
				return class[m](object, ...)
			end
		end
		return instance
	end
end
--------------------------------------------------------------------------------
local function interfaceToString(interface)
	print("this is a interface")
end
--------------------------------------------------------------------------------
function interface(super, ...)
	local methods = {}
	for i = 1, select("#", ...) do
		local method = select(i, ...)
		if type(method) == "string" and undefined(super, method) then
			methods[method] = dummy
		end
	end
	local interface = define({
		__call = cast,
		__index = super,
		__tostring = interfaceToString
	}, methods)

	interfaceMap[interface] = true
	return interface
end
--------------------------------------------------------------------------------
function implemented(class, ...)
	class = isclass(class) and class or classof(class)
	if class then
		if class.__interfaces then
			for i = 1, select("#", ...) do
				local interface = select(i, ...)
				if class.__interfaces[interface] ~= true then
					for _, m in iterator(interface) do
						if type(interface[m]) == "function" and not class[m] then
							return false, m
						end
					end
					class.__interfaces[interface] = true
				end
			end
			return true
		end
	end
	return false
end
--------------------------------------------------------------------------------
function isInterface(interface)
	return interfaceMap[interface] == true
end
--------------------------------------------------------------------------------
function isInterfaceInstance(object)
	return getmetatable(object) == instanceMT
end
--------------------------------------------------------------------------------
function superinterface(interface)
	return getmetatable(interface).__index
end
--------------------------------------------------------------------------------
function subinterfaceof(interface, super)
	while interface do
		if interface == super then return true end
		interface = superinterface(interface)
	end
	return false
end