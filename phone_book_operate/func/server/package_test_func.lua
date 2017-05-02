--用来将文件打包 package--

 func_name = "test_func" --功能的名称 
 __FILE__ = debug.getinfo(1,'S').source:sub(2) --当前的文件全路径

package_file_list = {
 "func/server/config.lua", 
  "lib/lib_JSON.lua",
  "lib/lib_file_operate.lua",
  "misc/ms_info.lua",
  "class/class_server.lua", 
  "class/class_ms.lua",
  "class/class_track.lua",
  "class/class_nv.lua",
  "lib/lib_sl_api.lua",
  "class/class_app_base.lua",      
}

dofile("../../lib/lib_file_operate.lua")  --添加文件操作
root_dir = get_prj_root_dir(__FILE__, 2); --根目录，当前目录往上2级
--current_dir 	= get_current_dir(__FILE__);
dofile(root_dir .. "package/sl_package.lua")  --打包

start_package(func_name, root_dir, package_file_list); 