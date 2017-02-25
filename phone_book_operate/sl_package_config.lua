--begin sl_package_config.lua
package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
package.path=package.path .. ";/private/var/touchelf/scripts/?.lua" .. ";/private/var/touchelf/scripts/sl/?.lua"
sl_globle_para = {  --全局变量
	is_package = true;    --是否是打包的程序
	package_info = "huangyike_V0.1"
}



sl_log_file       = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
sl_error_time     = 1;  --容错处理
--end sl_package_config.lua
is_delete_contact = false; --是否是执行删除操作

--全局配置参数
pre_fix_phone_numb   = {1865571}--1388888, 1355555, 1344444,1366666}--号段前缀，可以添加多个号码段
pre_fix_name = {"艾","毕","蔡","代","厄","方","甘","黄","马","赵","钱","孙","李","周","吴","郑","王"};



--mask_numb = 5   --尾后5位数，随机
--add_numb  = 50  --每次加的数目
--add_interval = 600;  --每次加号码后，休息的时间，单位秒
--del_contact_num = 10 --多少次后，直接删除所有的电话簿
--add_contact_num   = 4000;