--[[-------------------readme---------------
ms: moile station  移动终端
暂时不使用“协程”
sl: shunlian
]]--
--下载的脚本放在的地方
sl_fix_path = "/private/var/touchelf/scripts/sl/"   
sl_config_file = "/private/var/touchelf/scripts/sl/sl_config.txt" --配置文件
sl_log_file = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
package.path=package.path .. ";/private/var/touchelf/scripts/?.lua" .. ";/private/var/touchelf/scripts/sl/?.lua"

--require 文件
--require "server"
--require "config"
--require "file_log"
--------------------------------------------------------------------------------------------------------------config begin-------------------
g_sl_account = "kobe"
g_sl_password = "H11111111h"

default_ms_base_info = {	--json格式的数据
	ms_id = "ABCDEFG12345678"
	,ms_type = "ip4"   -- ip4,ip4s,ip5,ip5c,ip5s,ip6.ip6s
    ,ms_act = "kobe"
    ,ms_pwd = "H11111111h"
    ,ms_token = "shunliantianxia12345"
};

default_ms_task_info = {
	ms_stg_id = 40000
    , ms_task_id = 50000
    , ms_task_d_id = 50000
};

--从服务器得到的数据(格式)--
base_return_info = {
	Code = 101
	, Message = "成功"
	, TskId = 50001
	, TskPath = "http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg"
	, TskDataID = 50003
	, TskDataPath = "http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg"
	, StgID = 40003
}
--------------------------------------------------------------------------------------------------------------config end------------------

--------------------------------------------------------------------------------------------------------------file_log begin-------------------
require "string"
--获取路径  
function stripfilename(filename)
    return string.match(filename, "(.+)/[^/]*%.%w+$") --*nix system  
    --return string.match(filename, “(.+)\\[^\\]*%.%w+$”) — windows  
end    
--获取文件名  
function strippath(filename)  
    return string.match(filename, ".+/([^/]*%.%w+)$") -- *nix system  
    --return string.match(filename, “.+\\([^\\]*%.%w+)$”) — *nix system  
end  

--[[
local test_file = "http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg"
print(stripfilename(test_file))
print(strippath(test_file))
--]]
  
--去除扩展名  
function stripextension(filename)  
    local idx = filename:match(".+()%.%w+$")  
    if(idx) then  
        return filename:sub(1, idx-1)  
    else  
        return filename  
    end  
end  
  
--获取扩展名  
function getextension(filename)  
    return filename:match(".+%.(%w+)$")  
end  
 
--判断文件是否存在
function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end

--将二进制的文件转换成--
function fileToHexString(file)  
        local file = io.open(file, 'rb');
        local data = file:read("*all");
        notifyMessage( type(data) )
        file:close();
        local t = {};
        for i = 1, string.len(data),1 do
                local code = tonumber(string.byte(data, i, i));
                table.insert(t, string.format("%02x", code));
        end
        return table.concat(t, "");
end

--在文件（文本文件）中，找特定的字串--
function isStringInFile(mystring, file) 
    local BUFSIZE = 8192
    local f = io.open(file, 'r')  --打开输入文件
    
    while true do
        local lines,rest = f:read(BUFSIZE,"*line")
        if not lines then
            break
        end
        if rest then
            lines = lines .. rest .. "\n"
        end
        
        local i = string.find(lines,mystring);
        if nil ~= i then
            f:close();
            return true;
        end
    end
     f:close();
    return false;
 end   

--写字串到到文件中--
function writeStrToFile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
end

--初始化log文件
function logFileInit(log_file_name)   
    rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    rightnow_time = os.date("%H:%M:%S");
    local file_path = stripfilename(log_file_name)
    if false == file_exists(file_path) then  --创建自己的临时文件夹
          os.execute("mkdir -p " .. file_path);
    end
    writeStrToFile(rightnow_data .. " " .. rightnow_time .. "   ++++begin+++", log_file_name); 
end


--------------------------------------------------------------------------------------------------------------file_log end------------------
--------------------------------------------------------------------------------------------------------------server begin-------------------
--默认的值
--local default_server_addr = "http://120.76.215.162/sl_base/addons/xsy_resource/gettaskdemo.php?task="
local default_server_addr = "http://120.76.215.162/sl_base/addons/xsy_resource/gettask.php?task="
local test_data ={	--json格式的数据
	ms_id = "ABCDEFG12345678"
	, ms_type = "ip4"
    ,ms_act = "kobe" 
    ,ms_pwd = "H11111111h"
    ,ms_token = "shunliantianxia12345"
    , ms_stg_id = 40004
    , ms_task_id = 50005
    , ms_task_d_id = 50003
    , ms_status = "ideal" };

class_base_server = {
    server_addr = default_server_addr,
} 

--新建一个服务器--
function class_base_server:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    self.JSON =  require "JSON"
    return o    --最后返回构造后的对象实例
end

--设置服务器接口地址
function class_base_server:set_server_addr(addr) 
	self.server_addr = addr;
	return true;
end

--得到服务器接口地址
function class_base_server:get_server_addr()
	return self.server_addr;
end


--发送GET消息；参数sl_data为table型的数据
function class_base_server:send_info(sl_data)
    if type(sl_data) ~= 'table' then
        return false;
    end
    local raw_json_text = (self.JSON):encode(sl_data)  
    local xxxx = self.server_addr .. raw_json_text;
    local mydata = httpGet(xxxx);
    mSleep(1000);

    local ret_value = (self.JSON):decode(mydata)
    if nil == ret_value then --如果不是json数据，会返回nil
        return false
    else
        return ret_value
    end
end

--下载文件
--后期也可以改成luasocket的模式
function class_base_server:get_file(local_path,sl_url) 
	os.execute("curl -o " .. local_path .." " .. sl_url)
	return true;
end

--------------------------------------------------------------------------------------------------------------server end------------------


--得到本机的uuid
function get_ms_uuid()
	local  my_uuid =  getDeviceID(); 
	return my_uuid
end

--得到本机的型号
function get_ms_type()
	local my_ms_type = "ip4"
	width, height = getScreenResolution();                  -- 将屏幕宽度和高度分别保存在变量w、h中
	--脚本判断使用的机器是否是iphone5
	if width == 640 and height == 1136 then
	    my_ms_type = "ip5"  
	end
	return my_ms_type;
end

--得到本机当前时间
function get_local_time()
	local rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    local rightnow_time = os.date("%H:%M:%S");
    local my_time = rightnow_data .. ": " .. rightnow_time .. ": "
    return my_time;
end 

--输出错误信息到文件
function error_info(out_info)  ---错误处理函数   
	local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage(out_info);   
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(5000);
	os.exit(1);
end

--输出信息到文件
function log_info(out_info)  ---错误处理函数   
    --notifyMessage(out_info);
    local time = get_local_time(); 
    writeStrToFile("info:  " .. time .. out_info , sl_log_file);    
end

---------------------------------------------------------------------ms 对象--------------------
--发送给服务器的数据--
class_base_ms = {
    base_info = {	--json格式的数据
		ms_id = "ABCDEFG12345678"
		,ms_type = "ip4"   -- ip4,ip4s,ip5,ip5c,ip5s,ip6.ip6s
	    ,ms_act = "kobe"
	    ,ms_pwd = "H11111111h"
	    ,ms_token = "shunliantianxia12345"
	},
    now_task_info= {
		ms_stg_id = 40000     --策略ID
	    , ms_task_id = 50000  --任务ID
	    , ms_task_name = "test_task_0.lua" --任务名称
	    , ms_task_index = 5   --任务序号
	    , ms_task_d_id = 50000
	    , ms_task_d_name = "test_task_date_0.lua"
	}
} 

--初始化手机对象--
function class_base_ms:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self
    self.server = class_base_server:new()  
    return o    --最后返回构造后的对象实例
end

--得到当前状态--
function class_base_ms:get_status()  
	print("get_status");
end

--设置当前状态--
function class_base_ms:set_status()  
	print("set_status");
end

--执行任务--
function class_base_ms:run_task() 
	local my_taskname    = self.now_task_info.ms_task_name;
	local my_task_d_name = self.now_task_info.ms_task_d_name;

    my_taskname      = sl_fix_path .. my_taskname
    
    if nil ~= my_task_d_name then
        my_task_d_name   = sl_fix_path .. my_task_d_name
    end

    if nil ~= self.now_task_info.ms_task_d_name or type(my_task_d_name) ~= "string"  then  --脚本数据
        --do-nothing
    else
        dofile(my_task_d_name) --执行脚本
    end

	if type(my_taskname) ~= "string"  then
        return false
    else
    	--require "taskname执行脚本"
        dofile(my_taskname) --执行脚本
    end
end

--分析从服务器得到的信息
function class_base_ms:analy_server_data(task_info)
   
	if "string" ~= type(task_info.data.TaskPath) or "number" ~= type(task_info.data.TaskId) then
		error_info("接收服务器代码错误 ");
	end

	local new_task_name   = strippath(task_info.data.TaskPath);
	local local_task_file = sl_fix_path .. new_task_name;
	local new_task_data_name   = strippath(task_info.data.TaskDataPath);
	local local_task_data_file = nil
    if nil ~= new_task_data_name then
        local_task_data_file = sl_fix_path .. new_task_data_name;
    end
    
	if false == file_exists(local_task_file) then    --看本地是否存在
		self.server:get_file(local_task_file, task_info.data.TaskPath); --下载脚本
		mSleep(1000);
	end

	if nil ~= new_task_data_name and false == file_exists(local_task_data_file) then    --看本地是否存在
		self.server:get_file(local_task_data_file, task_info.data.TaskDataPath); --下载脚本数据
		mSleep(1000);
	end
	
	
	self.now_task_info.ms_task_id    = task_info.data.TaskId;
	self.now_task_info.ms_task_name  = new_task_name;
	self.now_task_info.ms_stg_id     = task_info.data.Strategy_ID;
	
	self.now_task_info.ms_task_d_name = new_task_data_name; --task_info.data.TaskDataPath;
	self.now_task_info.ms_task_d_id   = task_info.data.TaskDataID 
    return true;
end


--从服务器得到任务--
function class_base_ms:get_task()  	
    
    local task_info = nil;
	local mydata = {};
	local try_time = 0; --接收数据的次数
	for k,v in pairs(self.base_info) do
		--print(k,v)
		--table.insert(mydata, k, v)
        mydata[k] = v;
	end
	for k,v in pairs(self.now_task_info) do
		mydata[k] = v;
	end

	if nil ~= self.server then 
		while 2 >= try_time do
			task_info = self.server:send_info(mydata) --发送消息给服务器
			if false == task_info then
				try_time = try_time + 1;
				mSleep(3000);
			else
				break;
			end
		end
	end
    
	--得到服务器信息后处理--
	if nil ~= task_info and false ~= task_info then--如果是有效数据
		if task_info.Code == 101 then
			return self.analy_server_data(self,task_info) --注意这个地方，必须叫self。 by kobe
            --[[
            if "string" ~= type(task_info.data.TaskPath) or "number" ~= type(task_info.data.TaskId) then
                error_info("接收服务器代码错误 ");
            end
            local new_task_name   = strippath(task_info.data.TaskPath);
            local local_task_file = sl_fix_path .. new_task_name;
            
            if false == file_exists(local_task_file) then    --看本地是否存在
                self.server:get_file(local_task_file, task_info.data.TaskPath); --下载脚本
                mSleep(1000);
            end
            --self.run_task(new_task_name); --运行程序
            self.now_task_info.ms_task_id = task_info.data.TaskId;
            self.now_task_info.ms_task_name  = new_task_name;
            self.now_task_info.ms_stg_id  = task_info.data.Strategy_ID;
            --self.now_task_info.ms_task_d_name = 
            --self.now_task_info.ms_task_d_id = 
            return true;
            --]]
		else
			error_info("错误代码： " .. task_info.Code .. task_info.Message);
		end
	else
		return false
	end
end

--打印输出,带ms标签的log--
function class_base_ms:log()  
	print("log");
end


-----------------------------------------------------------------------------主程序-----------
sl_ms = {}; --当前手机对象
function init_ms()
	o = {};
	o.base_info = {};
	o.base_info.ms_id   =   get_ms_uuid();
	o.base_info.ms_type =   get_ms_type();
	o.base_info.ms_act  =   g_sl_account;
	o.base_info.ms_pwd  =   g_sl_password;
	
	sl_ms = class_base_ms:new(o);
	--print(sl_ms.now_task_info.ms_stg_id)
	--print(sl_ms.base_info.ms_id )
	return true;
end
--init_ms();

function init_sys()
	if false == file_exists(sl_fix_path) then  --创建脚本文件夹
          os.execute("mkdir -p " .. sl_fix_path);
    end
	logFileInit(sl_log_file); --log文件
    if true ~= init_ms() then
    	error_info("初始化手机错误！");
    end  
    return true;
end

notifyMessage( "开始执行脚本" );
mSleep(5000);

function main()
	--assert(false, "sdsdiahiuu")
	if true ~= init_sys() then
		error_info("初始化错误！");
		mSleep(5000);
        os.exit(1);
	end
	
	local my_result = false
	while true do 
		--sl_ms
		if true == sl_ms:get_task() then
			sl_ms:run_task();
			mSleep(1000);
		else
			error_info("运行脚本错误！");
		end
	end
end