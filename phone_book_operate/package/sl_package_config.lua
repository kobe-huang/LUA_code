--begin sl_package_config.lua--
package.path = package.path .. ";/d/kobe doc/code/github/LUA_code/phone_book_operate/package/?.lua" --直接用git-bash 就可以看到地址
package.path = package.path .. ";/private/var/touchelf/scripts/?.lua" .. ";/private/var/touchelf/scripts/sl/?.lua"

sl_globle_para = {  --全局变量
	is_package = true;    --是否是打包的程序
	package_info = "huangyike_V0.1"
}

__DEBUG__ = false -- debug 开关

--end sl_package_config.lua--
