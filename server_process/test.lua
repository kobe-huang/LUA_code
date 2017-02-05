function test_JSON()
    mystring = "{\"Code\":101,\"Message\":\"OK\",\"data\":{\"TaskId\":50005,\"TaskPath\":\"http:\\/\\/oss.temaiol.com\\/file\\/1\\/20170116\\/ffafadf22197d046a0db00bcd60db6a0.lua\",\"TaskDataID\":50003,\"TaskDataPath\":\"http:\\/\\/oss.temaiol.com\\/file\\/1\\/20170116\\/ffafadf22197d046a0db00bcd60db6a0.lua\",\"Strategy_ID\":40003}}"
    myJson = require "JSON"
    xxxx = myJson:decode(mystring);
    print(xxxx.data.TaskPath);
end


function test_dofile()
    --dofile("D:\\kobe doc\\code\\LUA\\bin\\v2.0.2\\env2.0.2\\projects\\lua_server\\scripts\\test_loadfile.lua")
    dofile("test_loadfile.lua")
    print(kobe)
    dofile("test_loadfile1.lua")
    --loadfile("D:\kobe doc\code\LUA\bin\v2.0.2\env2.0.2\projects\lua_server\scripts\test_loadfile1.lua")
    print(kobe)
end
function function_name( ... )
    notifyMessage("121212");
end
huangyinke = nil
if nil == huangyinke then
    function_name();
    --os.exit(1);
    --mSleep(100000)
end
--huangyinke = nil

--[[
kobe = {tt="kobe",yy = "yyy"}
huang = kobe
print(huang.tt)
kobe.tt = "yinke"
print(huang.tt)
print(kobe.tt)

function test_table()
    return kobe
end

tim = test_table();
tim.tt = "huang"

print(huang.tt)
print(kobe.tt)
print(tim.tt)
]]


--[[
function class_base_ms:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self
    --self.server = class_base_server:new()   
    return o    --最后返回构造后的对象实例
end

myclass = class_base_ms:new();

print(class_base_ms.base_info)
print(myclass.base_info);

class_base_ms.base_info = "kobe.huang"
print(myclass.base_info);

myclass.base_info = "huangyinke";
print(myclass.base_info);
print(class_base_ms.base_info)
]]--



function test_setmetatable()
    default_ms_base_info = {	--json格式的数据
    	ms_id = "ABCDEFG12345678"
    	,ms_type = "ip4"   -- ip4,ip4s,ip5,ip5c,ip5s,ip6.ip6s
        ,ms_act = "kobe" 
        ,ms_pwd = "H11111111h"
        ,ms_token = "shunliantianxia12345"
    };
    testsss={};
    setmetatable(testsss, default_ms_base_info)
    default_ms_base_info.__index = default_ms_base_info
    --setmetatable(o,self)
    --self.__index = self
    print(testsss.ms_id);
    print(default_ms_base_info.ms_id);

    testsss.ms_id = "XXXXXXXXXXX";

    print(testsss.ms_id);
    print(default_ms_base_info.ms_id);
end
--test_setmetatable()

function test_socket()
	-- socket方式请求
	local socket = require("socket")
	local host = "120.76.166.20"
	local file = "/"
	local sock = assert(socket.connect(host, 80))            -- 创建一个 TCP 连接，连接到 HTTP 连接的标准 80 端口上
	sock:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
	repeat
	    local chunk, status, partial = sock:receive(1024)    -- 以 1K 的字节块来接收数据，并把接收到字节块输出来
	    print(chunk or partial)
	until status ~= "closed"
	sock:close()  -- 关闭 TCP 连接
end

function test_json()
	   --data = httpGet('http://www.temaiol.com/sltx_techouol/demo.php')
    JSON = OBJDEF:new()
    --local lua_value = JSON:decode(data)
    local raw_json_text    = JSON:encode(test_data)        -- encode example
    --local pretty_json_text = JSON:encode_pretty(lua_value) -- "pretty printed" version

    mydate = httpGet( test_http_addr .. raw_json_text);
    local lua_value = JSON:decode(data)
    --data = httpGet('www.techouol.com');
    --data = os.execute("curl -o /var/touchelf/scripts/my12121.jpg http://sltx.techouol.com/attachment/attached/image/20161223/20161223150238_83875.jpg")
    --data = os.execute("cureel -d 'user=evan&password=12345' http://www.touchelf.com/login.php")
    notifyMessage(data)
    --http://www.temaiol.com/sltx_techouol/demo.php"？="{\"code\":200,\"message\":\"success\",\"data\":{\"score\":[70,95,70,60,\"70\"],\"name\":[\"Zhang San\",\"Li Si\",\"Wang Wu\",\"Zhao Liu\",\"TianQi\"]}}"
end

function printCallStack()
    local startLevel = 2 --0表示getinfo本身,1表示调用getinfo的函数(printCallStack),2表示调用printCallStack的函数,可以想象一个getinfo(0级)在顶的栈.
    local maxLevel = 10 --最大递归10层
 
    for level = startLevel, maxLevel do
        -- 打印堆栈每一层
        local info = debug.getinfo( level, "nSl") 
        if info == nil then break end
        print( string.format("[ line : %-4d]  %-20s :: %s", info.currentline, info.name or "", info.source or "" ) )
 
        -- 打印该层的参数与局部变量
        local index = 1 --1表示第一个参数或局部变量, 依次类推
        while true do
            local name, value = debug.getlocal( level, index )
            if name == nil then break end
 
            local valueType = type( value )
            local valueStr
            if valueType == 'string' then
                valueStr = value
            elseif valueType == "number" then
                valueStr = string.format("%.2f", value)
            end
            if valueStr ~= nil then
                print( string.format( "\t%s = %s\n", name, value ) )
            end
            index = index + 1
        end
    end
end
