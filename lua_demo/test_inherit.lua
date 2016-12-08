local _a1 = {20, 1, key1 = "hello", key2 = "world", lang = "lua"}
print("the table _a1:")
for _,v in pairs(_a1) do
    print(v)
end

local _a2 = {
    key1 = "hello new",
    key2 = "world new"
}

print("\nthe old table _a2:")
for _,v in pairs(_a2) do
    print(v)
end


print("\na2的metatable:",getmetatable(_a2))
print("language:",_a2["lang"])


-- 关注函数及__index
setmetatable(_a2, {__index = _a1})


print("\nthe new table _a2:")
for _,v in pairs(_a2) do
    print(v)
end

local _a3 = {
    key1 = "a3 new",
    key2 = "a3 new"
}
setmetatable(_a3, {__index = _a2})

print("\n language:", _a2["lang"])
print("\n a3 language:", _a3["key1"])
print("\n a3 language:", _a3["lang"])   --会继承a1 的数据
