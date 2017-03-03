--[[-------------------readme---------------
ms: moile station  移动终端
暂时不使用“协程”
sl: shunlian
]]--
--下载的脚本放在的地方

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

--系统初始化
function init_sys()
	if false == file_exists(sl_fix_path) then  --创建脚本文件夹
          os.execute("mkdir -p " .. sl_fix_path);
    end
	logFileInit(sl_log_file); --初始化log文件
    if true ~= init_ms() then
    	error_info("初始化手机错误！");
    end  
    return true;
end

notifyMessage( "开始执行服务器脚本" );
--mSleep(5000);

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