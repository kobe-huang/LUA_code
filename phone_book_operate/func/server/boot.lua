local_current_path = "/private/var/touchelf/scripts/"
g_server_list = {
	"http://lua-script.oss-cn-shenzhen.aliyuncs.com/",
	"http://120.77.34.177/sl_base/data/",
	"http://120.76.215.162/sl_base/data/"
};

g_main_name_list = {
	"sl_main.lua.E2",
	"sl_main.lua",
	"sl_main.lua.E3"
};

--http://lua-script.oss-cn-shenzhen.aliyuncs.com/sl_main.lua.E2

sl_user_login_file =  "/private/var/touchelf/scripts/sl/user_info.lua"  --放着用户的登录信息   
--sl_error_time     = 1;  --容错处理,  现在不做容错处理。
g_sl_account   = "kobe_test"  --默认的值
g_sl_password  = "H11111111h" --默认用户的密码

function boot_isStringInFile(mystring, file)  --在文件（文本文件）中，找特定的字串--
    local BUFSIZE = 8192
    local f = io.open(file, 'r')  --打开输入文件  
    while true do
        local lines,rest = f:read(BUFSIZE,"*line")
        if not lines then
            break
        end
        if rest then
            lines = lines .. rest .. "\n"
        end
        
        local i = string.find(lines,mystring);
        if nil ~= i then
            f:close();
            return true;
        end
    end
     f:close();
    return false;
end   

function boot_clean_file(file)
    local f = io.open(file, 'w+');
    f:close();
end

--判断文件是否存在
function boot_file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end

--获取路径，去除文件名  
function boot_strip_file_name(filename)  --
    if filename:match(".-/.-") then 
        return string.match(filename, "(.+)/[^/]*%.%w+$")   --*nix system 
    elseif filename:match(".-\\.-") then   
        return string.match(filename, "(.+)\\[^\\]*%.%w+$") -- windows
    else  
        return nil
    end   
end   

--写字串到到文件中--
function boot_writeStrToFile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
end

function check_download_main_file(path)
	-- body
	--oss下载错误会有NoSuchKey， nginx下载错误会有"404"
	if false == boot_isStringInFile("NoSuchKey", path)  and  false == boot_isStringInFile("404 Not Found", path)  then
		return true;
	else
		return false;
	end
end

--从服务器上下载主程序
function get_main_file(local_path,sl_url) 
    local try_time = 1
    while 2 >= try_time do
        os.execute("curl -o " .. local_path .." " .. sl_url);
        mSleep(1000*try_time);  --时间逐步加长
        if true == boot_file_exists(local_path) then --只看是否下载下来
        	if true == check_download_main_file(local_path) then	
            	return true;
            else
            	try_time = try_time + 1;
            end
        else
            try_time = try_time + 1;
        end
    end
    return false; 
end

--去服务器取主程序，并运行
function get_main_and_run()
	for _, server_path in pairs(g_server_list) do
		--print(k,v)
		for __, main_path in pairs(g_main_name_list) do
			local local_path  = local_current_path .. main_path;
			local remote_path = server_path .. main_path;
			if true == get_main_file(local_path, remote_path) then
				--运行程序
				dofile(local_path); --直接运行main函数
				os.exit(1);
			else
				--啥都不干
			end
		end
	end
	notifyMessage( "初始化失败,请联系VX：huangyinke3");	--会延迟1s
	mSleep(3000);
	os.exit(1);
end

----------------------------------------------------------------------------------------
if boot_file_exists(sl_user_login_file) then
    dofile(sl_user_login_file);
end

user_login_file_path = boot_strip_file_name(sl_user_login_file);
if false == boot_file_exists(user_login_file_path) then  --创建自己的临时文件夹
    os.execute("mkdir -p " .. user_login_file_path);
end

UI = {
        { 'TextView{-请输入你的账号密码-}' },
        { 'InputBox{'..g_sl_account..'}',    'current_account',    '账号:' },
        { 'InputBox{'..g_sl_password..'}',   'current_pwd',    '密码:' },
};

function set_user_info()
	if g_sl_account == current_account and g_sl_password == current_pwd then 
	    --notifyMessage("账号密码");  
	else
	    g_sl_account    = current_account;
	    g_sl_password   = current_pwd;
	    boot_clean_file(sl_user_login_file);
	    boot_writeStrToFile("g_sl_account = " .. "'" .. g_sl_account.. "'", sl_user_login_file);
	    boot_writeStrToFile("g_sl_password = " .."'" ..g_sl_password.. "'", sl_user_login_file);
	    notifyMessage("设置新的账号密码");
	    mSleep(1000);
	end
    if g_sl_account ==  "kobe_test" and g_sl_password == "H11111111h" then
		notifyMessage("请更换默认用户和密码");
		mSleep(1000);
	end	 
end
-----------------------------------------------------------------------------------------------------------

function main()
	-- body
	set_user_info();
	get_main_and_run();
end

-- function main()
-- 	-- body
-- 	test_get_main_file();
-- end

-- function test_get_main_file()
-- 	local x = 1
-- 	local l_local_path = "/private/var/touchelf/scripts/test.lua" 
-- 	local l_sl_url = "http://lua-script.oss-cn-shenzhen.aliyuncs.com/test.lua"
-- 	--local l_sl_url = "http://120.77.34.177/sl_base/data/test.lua"
-- 	local result = get_main_file(l_local_path, l_sl_url);
-- 	notifyMessage('result = ' .. result ) ;
-- end
