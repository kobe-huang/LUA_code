--begin sl_package_config.lua
package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
package.path=package.path .. ";/private/var/touchelf/scripts/?.lua" .. ";/private/var/touchelf/scripts/sl/?.lua"
local sl_globle_para = {  --全局变量
	is_package = true;    --是否是打包的程序
	package_info = "huangyike_V0.1"
}

is_delete_contact = false;
add_contact_num   = 4000;
sl_log_file       = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
sl_error_time     = 1;  --容错处理
--end sl_package_config.lua
