--begin sl_package_config.lua
package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
package.path=package.path .. ";/private/var/touchelf/scripts/?.lua" .. ";/private/var/touchelf/scripts/sl/?.lua"
local sl_globle_para = { 
	is_package = true; 
	package_info = "huangyike_V0.1"
}

is_delete_contact = false;
sl_log_file    = "/private/var/touchelf/scripts/sl/sl_log.txt" --log文件
g_sl_account   = "kobe"
g_sl_password  = "H11111111h"
sl_fix_path    = "/private/var/touchelf/scripts/sl/"   
sl_config_file = "/private/var/touchelf/scripts/sl/sl_config.txt" --配置文件


