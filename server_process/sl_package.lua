--用来将文件打包 package--
local package_name = "sl_main.lua"
local package_file_list = {
  "sl_package_config.lua",
  "./lib/lib_JSON.lua",
  "./misc/ms_info.lua",
  "./misc/file_log.lua",
  "./class/class_server.lua", 
  "./class/class_ms.lua",
  "main.lua"               
}

function file_save_load(filename, file)
	local myfile = io.open(filename, "r");
	assert(myfile);
	local data = myfile:read("*a"); -- 读取所有内容
	myfile:close();
	file:write(data);
end

function start_package()
	file = io.open(package_name,"w");  --覆盖文件
	file:write("------------------------" .. package_name .."--------\n");
	file:write("--                                             --\n");
	file:write("--                                             --\n");
	rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
  rightnow_time = os.date("%H:%M:%S");
  time = "--" .. rightnow_data .. "  " .. rightnow_time .. "     kobe package \n"
	file:write(time)
	file:write("--                                             --\n");
	file:write("--                                             --\n");
	file:write("--                                             --\n");
	file:write("-------------------------------------------------\n\n\n\n");
	file:close();

	file = io.open(package_name,"a");
	for i,v in ipairs(package_file_list) do		
		file:write("\n\n\n\n" .. "----------------------begin:  " .. v .. "---------------------------------\n")
		file_save_load(v, file);
		file:write("\n" .. "------------------end:  " .. v .. "-------------------------------------\n")
		
	end
	file:close();
end

--开始打包
start_package() 
