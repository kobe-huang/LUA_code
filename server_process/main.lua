--[[-------------------readme---------------
ms: moile station  移动终端
暂时不使用“协程”
sl: shunlian
]]--
--下载的脚本放在的地方
sl_fix_path = "/private/var/touchelf/scripts/sl/"   
sl_config_file = "/private/var/touchelf/scripts/sl/sl_config.txt" --配置文件

--require 文件
--require "server"
--require "config"
--require "file_log"
--------------------------------------------------------------------------------------------------------------config begin-------------------

default_ms_task_info = {
	ms_stg_id = 40000
    , ms_task_id = 50000
    , ms_task_d_id = 50000
};

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