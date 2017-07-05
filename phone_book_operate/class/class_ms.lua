default_ms_task_info = { --任务的掩码
	ms_stg_id = 40000
    , ms_task_id = 50000
    , ms_task_data_id = 50000
};

-----------------------------------------------------------------ms 对象--------------------
--发送给服务器的数据--
class_base_ms = {
    base_info = {	--json格式的数据
		ms_id = "ABCDEFG12345678"
		,ms_type = "ip4"   -- ip4,ip4s,ip5,ip5c,ip5s,ip6.ip6s
	    ,ms_act = "kobe"
	    ,ms_pwd = "H11111111h"
	    ,ms_token = "shlnliantianxia12345"
	},
    current_task_info = {
		ms_stg_id    = 40000  --策略ID
	    , ms_task_id = 50000  --任务ID
	    , ms_task_name = "test_task_0.lua" --任务名称
	    , ms_task_index = 5   --任务序号
	    , ms_task_data_id = 50000
	    , ms_task_data_name = "test_task_date_0.lua"  --当前执行的任务
	    , ms_user_config = "xxx.lua"  ---用户的数据
	},
	user_info = {
		user_id 	= 0;
		ms_index 	= 0;
	},
} 

--初始化手机对象--
function class_base_ms:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self
    self.server = class_base_server:new() --初始化服务器对象  
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
	local my_task_name    = self.current_task_info.ms_task_name;
	local my_task_data_name  = self.current_task_info.ms_task_data_name;
	local my_user_config  = self.current_task_info.ms_user_config;

    my_task_name = sl_fix_path .. my_task_name
    if false == file_exists(my_task_name) then
    	warning_info("文件不存在" .. my_task_name);
    	return false;
    end

--------------------
    if nil ~= my_task_data_name then
        my_task_data_name   = sl_fix_path .. my_task_data_name
    end

    if nil == self.current_task_info.ms_task_data_name or false == file_exists(my_task_data_name)  then  --脚本数据
        --do-nothing
    else
        dofile(my_task_data_name) --加载脚本的数据
    end
-------------------
    if nil ~= my_user_config then
        my_user_config   = sl_fix_path .. my_user_config
    end

    if nil == self.current_task_info.ms_user_config or false == file_exists(my_user_config)  then  --脚本数据
        --do-nothing
    else
        dofile(my_user_config) --加载脚本的数据
    end
-------------
	--require "taskname执行脚本"
    dofile(my_task_name) --执行脚本
end

--分析从服务器得到的信息
function class_base_ms:analy_server_data(task_info)
   
	if "string" ~= type(task_info.data.task_path) or "number" ~= type(task_info.data.task_id) then
		error_info("接收服务器代码错误! ");
	end

	local new_task_name   = strip_path(task_info.data.task_path);
	local local_task_file = sl_fix_path .. new_task_name;
	
	local new_task_data_name   = nil 
	if "string" == type(task_info.data.task_data_path) then new_task_data_name =  strip_path(task_info.data.task_data_path) end
	local new_user_config 	   = nil 
	if "string" == type(task_info.data.user_config_path) then new_user_config =  strip_path(task_info.data.user_config_path) end
	
-----
	self.user_info.user_id 	= task_info.data.user_id;
	self.user_info.ms_index = task_info.data.ms_index;
	set_var_item("var_user_id", task_info.data.user_id);
	set_var_item("var_ms_index", task_info.data.ms_index);
-----

	local local_task_data_file = nil
    if nil ~= new_task_data_name then
        local_task_data_file = sl_fix_path .. new_task_data_name;
    end
    
    local local_user_config_file = nil
    if nil ~= new_user_config then
        local_user_config_file = sl_fix_path .. new_user_config;
    end

	if false == file_exists(local_task_file) then                       --看本地是否存在
		self.server:get_file(local_task_file, task_info.data.task_path); --下载脚本
		--mSleep(1000);
	end

	if nil ~= new_task_data_name and false == file_exists(local_task_data_file) then    --看本地是否存在
		self.server:get_file(local_task_data_file, task_info.data.task_data_path); --下载脚本数据
		--mSleep(1000);
	end	

	if nil ~= new_user_config and false == file_exists(local_user_config_file) then    --看本地是否存在
		self.server:get_file(local_user_config_file, task_info.data.user_config_path); --下载用户配置数据
		--mSleep(1000);
	end

	self.current_task_info.ms_task_id    	= task_info.data.task_id;
	self.current_task_info.ms_task_data_id  = task_info.data.task_data_id; 
	self.current_task_info.ms_stg_id     	= task_info.data.strategy_id;

	self.current_task_info.ms_task_name   		= new_task_name;	
	self.current_task_info.ms_task_data_name 	= new_task_data_name; --task_info.data.TaskDataPath;
	self.current_task_info.ms_user_config 		= new_user_config;

	if "string" == type(task_info.data.token) then  --加上token，先要看是否有token
		self.base_info.ms_token		  = task_info.data.token;
	end
    return true;
end


--从服务器得到任务--
--返回参数： false  失败
--          true   成功
function class_base_ms:get_task()  	
    
    local task_info = nil;
	local mydata = {};
	local try_time = 1; --接收数据超时的次数
	for k,v in pairs(self.base_info) do
		--print(k,v)
		--table.insert(mydata, k, v)
        mydata[k] = v;
	end
	-- for k,v in pairs(self.current_task_info) do --实际使用中可以去掉。
	-- 	mydata[k] = v;
	-- end

	if nil ~= self.server then           --如果得到任务不成功，try几次
		while 4 >= try_time do
			task_info = self.server:send_info(mydata) --发送消息给服务器
			if false == task_info then
				try_time = try_time + 1;
				mSleep(1500*try_time);  --sleep时间逐渐加长
			else
				break;
			end
		end
	end
    
	--得到服务器信息后处理--
	if nil ~= task_info and false ~= task_info then--如果是有效数据
		if task_info.code == 101 then              --判断是否是正确的代码 
			--return self.analy_server_data(self,task_info) --注意这个地方，必须加self，因为不是 “：”调用。 by kobe
			return self:analy_server_data(task_info)  --或者改成 self:analy_server_data(task_info)
		else
			error_info("错误代码： " .. task_info.code .. task_info.message);
			return false;
		end
	else
		error_info("网络或服务器异常！休眠15分钟");
		mSleep(1000*60*15);
		--mSleep(1000*30);
		return false
	end
end


--给服务器发送指令，请求重置设备任务
function class_base_ms:reset_server_task_list()
end  	

--给服务器发送统计信息
function class_base_ms:send_statistic_info()
	-- body
end

--打印输出,带ms标签的log--
function class_base_ms:log()  
	print("log");
end


function class_base_ms:send_info(records_table)  
    local task_info = nil;
	local mydata = {};
	local try_time = 1; --接收数据超时的次数
	for k,v in pairs(self.base_info) do
        mydata[k] = v;
	end
	for k,v in pairs(records_table) do
		mydata[k] = v;
	end
 	self.server:send_info(mydata); --发送消息给服务器
 end