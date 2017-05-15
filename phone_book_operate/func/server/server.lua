--[[-------------------readme---------------
ms: moile station  移动终端
暂时不使用“协程”
sl: shunlian
]]--
--下载的脚本放在的地方

-----------------------------------------------------------------------------主程序----------

sl_ms = {}; --当前手机对象
function init_ms()
	o = {};
	o.base_info = {};
	o.base_info.ms_id   =   get_ms_uuid();
	o.base_info.ms_type =   get_ms_type();
	o.base_info.ms_act  =   g_sl_account;
	o.base_info.ms_pwd  =   g_sl_password;
	
	sl_ms = class_base_ms:new(o);
	--print(sl_ms.current_task_info.ms_stg_id)
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

--boot 文件处理,同步boot文件 
function sync_boot_file( ... )
	-- body
	local tmp_return;
	
	if nil == sl_remote_boot_file or "string" ~= type(sl_remote_boot_file) then
		return false;
	end
	if nil == sl_boot_file_name or "string" ~= type(sl_boot_file_name) then
		return false;
	end
	if nil == sl_root_dir or "string" ~= type(sl_root_dir) then
		return false;
	end

	if boot_code_version == nil  or boot_code_version ~= sl_boot_version then
		local local_path = sl_root_dir .. "boot.lua.E2";
		local new_boot_path = sl_root_dir .. sl_boot_file_name;
		if false == download_remote_file(local_path, sl_remote_boot_file) then
			return false;
		end
		os.execute("mv " .. local_path .. " " .. new_boot_path);
		return true;
	end
end

function sl_main()
	--assert(false, "sdsdiahiuu")
	--打印出 服务器版本号和 对应的boot版本号
	notifyMessage( "服务器版本: " .. sl_main_version .. "&" .. sl_boot_version);	--会延迟1s
	mSleep(2000);
	if true ~= init_sys() then
		error_info("初始化错误！");
		mSleep(5000);
        os.exit(1);
	end
	sync_boot_file(); --同步服务器boot
	local my_result = false
	init_track(); --初始化记录工具
	init_nv();
	--test_nv();

	while true do 
		--sl_ms
		if true == sl_ms:get_task() then
			sl_ms:run_task();
			mSleep(100);
		else
			error_info("运行脚本错误！");
		end
	end
end

sl_main();

-----------------------------------------接口测试-------------------------
--测试：
--1. 清除手机中的脚本，及一切缓存数据; 
--2. 注释掉上面的sl_main
--3. 设置下面的 account 和 password
--4. 打开下面main函数


-- g_sl_account 	= "kobe";
-- g_sl_password 	= "H11111111h"
-- function main( ... )
-- 	os.execute("rm -rf /private/var/touchelf/scripts/sl"); --1. 清除手机中的脚本，及一切缓存数据;
-- 	sl_main();
-- 	-- body
-- end

-- my_index = 0;
-- function test_nv_track_reset()
-- 	if my_index <= 8 then
-- 		track_write_record_item('index_'..my_index,  my_index);
-- 		nv_write_nv_item('nv_index_'..my_index, my_index);
-- 	else
-- 		reset_ms_server();
-- 		nv_write_nv_item('nv_reset'..my_index, my_index);
-- 		my_index = 0;
-- 	end
-- end