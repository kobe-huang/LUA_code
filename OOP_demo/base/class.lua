--[[class.lua
提供类的继承机制

Exported API:
	class(super, ...)
	new(class, ...)
	release(object)
	classof(object)
	islass(class)
	instanceof(object, class)
	superclass(class)
	subclassof(class, supe)
	getInterfaces(class)
	isClassInstance(object)

Example:
--]]

require "base.base"
require "base.interface"
require "base.singleton"

--------------------------------------------------------------------------------
local advance = true
local classMap = define { __mode = "k" }
--------------------------------------------------------------------------------
local function rawnew(class, object, ...)
	if isclass(class.__super) then
		rawnew(class.__super, object, ...)
	end
	if type(class.__init) == "function" then
		class.__init(object, ...)
	end
	return object
end
--------------------------------------------------------------------------------
function new(class, ...)
	if not class.__implemented then
		local interfaces = getInterfaces(class)
		if interfaces then
			advance = false
			local ret, method = implemented(class, unpack(interfaces))
			advance = true
			if not ret then
				print(string.format("The %q not implemented.", method))
			end
		end
		class.__implemented = true
	end
	if table.contains(getInterfaces(class), Singleton) then
		local inst = rawget(class, "__instance")
		if not inst then
			local object = define(class.__vtbl)
			inst = rawnew(class, object, ...)
			rawset(class, "__instance", inst)
		end
		return inst
	else
		local object = define(class.__vtbl)
		return rawnew(class, object, ...)
	end
end
--------------------------------------------------------------------------------
local function rawrelease(class, object)
	if type(class.__release) == "function" then
		class.__release(object)
	end
	if isclass(class.__super) then
		rawrelease(class.__super, object)
	end
end
--------------------------------------------------------------------------------
function release(object)
	local class = classof(object)
	if class then
		rawrelease(class, object)
	end
end
--------------------------------------------------------------------------------
local classMT = {
	__call = new,
	__index = function(class, field)
		local value = class.__vtbl[field]
		if advance and value and not string.startsWith(field, "_") then
			rawset(class, field, value)
		end
		return value
	end,
	__newindex = function(class, field, value)
		class.__vtbl[field] = value
	end,
	__tostring = function(class)
		return "this is a class"
	end
}
--------------------------------------------------------------------------------
local function object_tostring(object)
	if type(object.tostring) == "function" then
		return object:tostring()
	end
	return "this is a class"
end
--------------------------------------------------------------------------------
function own_class(super, ...)
	local interfaces = {}
	for i = 1, select("#", ...) do
		local interface = select(i, ...)
		if isInterface(interface) then
			interfaces[#interfaces + 1] = interface
		end
	end

	local vtbl = {
		__tostring = object_tostring,
		release = release,
	}

	vtbl.__index = vtbl

	local class = define(classMT, {
		__super = super,
		__interfaces = #interfaces > 0 and interfaces or nil,
		__vtbl = vtbl,
		__init = false,
		__release = false,
	})

	classMap[vtbl] = class

	if super then
		define({
			__index = class.__super
		}, vtbl)
	end

	return class
end
--------------------------------------------------------------------------------
function isclass(class)
	local mt = getmetatable(class)
	if mt == classMT then return true end
	if classMap[mt] then return true end
	return false
end
--------------------------------------------------------------------------------
function classof(object)
	local mt = getmetatable(object)
	return classMap[mt]
end
--------------------------------------------------------------------------------
function isClassInstance(object)
	return classof(object) ~= nil
end
--------------------------------------------------------------------------------
function getInterfaces(class)
	class = isclass(class) and class or classof(class)
	return class.__interfaces
end
--------------------------------------------------------------------------------
function superclass(class)
	return rawget(class, "__super")
end
--------------------------------------------------------------------------------
function subclassof(class, super)
	while class do
		if class == super then return true end
		class = superclass(class)
	end
	return false
end
--------------------------------------------------------------------------------
function instanceof(object, class)
	if object then
		if isInterfaceInstance(object) then
			return subinterfaceof(object.__interface, class)
		elseif isClassInstance(object) then
			if isclass(class) then
				return subclassof(classof(object), class)
			elseif isInterface(class) then
				local interface = class
				local class = classof(object)
				while class do
					local interfaces = getInterfaces(class) or {}
					for i = 1, #interfaces do
						if subinterfaceof(interfaces[i], interface) then
							return implemented(class, interface)
						end
					end
					class = superclass(class)
				end
			end
		end
	end
	return false
end