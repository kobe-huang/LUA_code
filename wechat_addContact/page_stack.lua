---------------------------------------------------------------

-- 一个简单的栈,非递归遍历二叉树的时候需要用一下
-- @class module
-- @name class_page_stack
-- @author liqiang

class_page_stack = {}
function class_page_stack:new()
    local copy = {
    }
    setmetatable(copy, self)
    self.__index = self
    return copy
end

--[[--
得到栈内元素数量
@treturn number size 元素个数
]]

function class_page_stack:size()
    return #self
end

--[[--
栈是否为空
@treturn boolean b true为空,否则为不空
]]

function class_page_stack:empty()
    return (self:size() == 0)
end

--[[--
出栈
@treturn void value 返回删除的元素,空返回nil
]]

function class_page_stack:pop()
    local tmp = self:top()
    table.remove(self)
    return tmp
end

--[[--
入栈
@tparam void value 入栈的元素
@treturn number size 入栈后元素个数
]]

function class_page_stack:push(value)
    table.insert(self, value)
    return self:size()
end

--[[--
得到栈顶元素
@treturn void value 栈顶元素,空返回nil
]]

function class_page_stack:top()
    local size = self:size()
    if size == 0 then
    return nil
    end
    return self[size]
end
--

page_stack = class_page_stack:new();

--return class_page_stack

-------------------------------------------------test----------------------------------------------------------
--[[
local function f(test)
    print("---------------------size-", test:size())
    print("---------------------isempty", test:empty())
end

local test = class_page_stack:new()
f(test)
print(test:push(1))
print(test:push(2))
print(test:top())
print(test:pop())
print(test:top())
print(test:pop())
print(test:pop())
print(test:top())
f(test) 
--]]