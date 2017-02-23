------------------------sl_func_phone_book_opt.lua--------
--                                             --
--                                             --
--20170223  13:01:48     kobe package 
--                                             --
--                                             --
--                                             --
-------------------------------------------------







----------------------begin:  sl_package_config.lua---------------------------------
--begin sl_package_config.lua
package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
package.path=package.path .. ";/private/var/touchelf/scripts/?.lua" .. ";/private/var/touchelf/scripts/sl/?.lua"
local sl_globle_para = {  --全局变量
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
------------------end:  sl_package_config.lua-------------------------------------




----------------------begin:  ./lib/lib_file_log.lua---------------------------------
--begin lib_file_log.lua
require "string"
--获取路径  
function stripfilename(filename)
    return string.match(filename, "(.+)/[^/]*%.%w+$") --*nix system  
    --return string.match(filename, “(.+)\\[^\\]*%.%w+$”) — windows  
end    
--获取文件名  
function strippath(filename)  
    return string.match(filename, ".+/([^/]*%.%w+)$") -- *nix system  
    --return string.match(filename, “.+\\([^\\]*%.%w+)$”) — *nix system  
end  

--去除扩展名  
function stripextension(filename)  
    local idx = filename:match(".+()%.%w+$")  
    if(idx) then  
        return filename:sub(1, idx-1)  
    else  
        return filename  
    end  
end  
  
--获取扩展名  
function getextension(filename)  
    return filename:match(".+%.(%w+)$")  
end  
 
--判断文件是否存在
function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end

--将二进制的文件转换成--
function fileToHexString(file)  
        local file = io.open(file, 'rb');
        local data = file:read("*all");
        notifyMessage( type(data) )
        file:close();
        local t = {};
        for i = 1, string.len(data),1 do
                local code = tonumber(string.byte(data, i, i));
                table.insert(t, string.format("%02x", code));
        end
        return table.concat(t, "");
end

--在文件（文本文件）中，找特定的字串--
function isStringInFile(mystring, file) 
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

--写字串到到文件中--
function writeStrToFile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
end


-----------------------------------------------------------------------log----------------------------------------
--初始化log文件
function logFileInit(log_file_name)   
    rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    rightnow_time = os.date("%H:%M:%S");
    local file_path = stripfilename(log_file_name)
    if false == file_exists(file_path) then  --创建自己的临时文件夹
          os.execute("mkdir -p " .. file_path);
    end
    writeStrToFile(rightnow_data .. " " .. rightnow_time .. "   ++++begin+++", log_file_name); 
end

--得到本机当前时间
function get_local_time()
    local rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    local rightnow_time = os.date("%H:%M:%S");
    local my_time = rightnow_data .. ": " .. rightnow_time .. ": "
    return my_time;
end 

--输出信息到文件
function log_info(out_info)  ---错误处理函数   
    --notifyMessage(out_info);
    local time = get_local_time(); 
    writeStrToFile("info:  " .. time .. out_info , sl_log_file);    
end

function error_info_exit(out_info)  ---错误处理函数   
    local time = get_local_time(); 
    writeStrToFile("fatal error:  " .. time .. out_info , sl_log_file); 
    notifyMessage(out_info);   
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(5000);
    --page_array["page_main"]:enter();  --重新开始
    os.execute("reboot");
    --os.exit(1);
end

function error_info(out_info)  ---错误处理函数   
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage(out_info);   
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(5000);
    sl_error_time = sl_error_time + 1;
    if sl_error_time >= 30 then
        error_info_exit("致命错误，退出---");
    else
        page_array["page_main"]:enter();  --重新开始
    end
    --os.exit(1);
end

--[[
local test_file = "http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg"
print(stripfilename(test_file))
print(strippath(test_file))
--]]

--function LogToFile
--end lib_file_log.lua
------------------end:  ./lib/lib_file_log.lua-------------------------------------




----------------------begin:  ./class/class_base_page.lua---------------------------------
--class_base_page.lua begin--
class_base_page = {
    page_name = "default_page", 
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/default_page.bmp",
    page_action_list = {}  --进入这个页面的处理
   -- page_snap_iamge = {} --截图数组，hash数组
} 

function class_base_page:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    return o    --最后返回构造后的对象实例
end

--step1
function class_base_page:enter()        --进入页面后的动作--
    print("class_base_page:enter");
    --print(self.page_name);
end

--step2
function class_base_page:check_page()  --检查是否是在当前页面--
    print("class_base_page:check_page");
    --print(self.page_name)
    return true;
end

function class_base_page:quick_check_page()  --快速检查页面--
    print("class_base_page:check_page");
    --print(self.page_name)
    return true;
end


--step3
function class_base_page:action()     --执行这个页面的操作--
    print("class_base_page:check_page");
    --print(self.page_name)
    return true;
end

--
function class_base_page:getPageName()  --得到这个页面的名字
    return self.page_name;
end
--

--function sl_init_page
--class_base_page.lua end--
------------------end:  ./class/class_base_page.lua-------------------------------------




----------------------begin:  ./page/page_all_data.lua---------------------------------
----begin page_all_data.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--文件说明： 初始化页面数组；
page_array = {} --所有的page table

--初始化页面
function init_page(b)  
    if b.page_name then --如果是用打包的方式，页面初始化已经在各自的页面文件里面
    	if true == sl_globle_para.is_package then 
    		--donothing
            --page_array[b.page_name] = b.page_name:new() --放在各个page里面
    	else
	        require(b.page_name) --初始化页面对象
	        print("test");
	    end
    end
end

--得到当前的页面，返回页面的名称
function get_current_page()
    for k,v in pairs(page_array) do 
        if true == page_array[k]:quick_check_page() then
            return k;
        end
    end
    return false
end


init_page{
    page_name = "page_main", --聊天主界面-群聊天
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};

init_page{
    page_name = "page_suoyoulianxiren",    --所有联系人界面--添加新联系人
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};
init_page{
    page_name = "page_xinlianxiren", --聊天主界面-群聊天
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};

init_page{
    page_name = "page_lianxirenxiangqing", --联系人详情界面 --删除联系人
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};

----begin page_all_data.lua
------------------end:  ./page/page_all_data.lua-------------------------------------




----------------------begin:  ./page/page_main.lua---------------------------------
--begin page_main.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"
default_main_page = {
	page_name = "main_page",
	page_image_path = nil
}

main_page = class_base_page:new(default_main_page);

local function touch_middle()
    rotateScreen(0);
    mSleep(1600);
    touchDown(4, 348, 896)
    mSleep(240);
    touchUp(4)
    mSleep(1000);
end
local function check_page_main( ... )
	x, y = findMultiColorInRegionFuzzy({ 0x4CB2DB, 7, 0, 
		0x4CB1D9, 9, 0, 0x75C3E2, 12, 0, 
		0x4BB1D8, 16, 0, 0x4BB1D6, 21, 0, 
		0x4BB0D6, 10, 10, 0xFFFFFF, 12, 0, 
		0x4BB1D8, 13, 5, 0x4BB1D7, 3, 5, 
		0xDAEFF7, 11, 4, 0xCAE8F3, 21, 4, 
		0x4CB1D7, 17, 4, 0xF7FCFD, 38, 4, 0x64BEDE }, 
		90, 70, 933, 108, 943);
	if x ~= -1 and y ~= -1 then  -- 如果找到了
	   return true;
	else
		return false;
	end
end
--操作电话本
local function action_main_contact_opt() --执行这个页面的操作--
    print("main_page:check_page");
    --print(self.page_name);
    rotateScreen(0);
    mSleep(1800);
    touchDown(8, 128, 834)
    mSleep(190);
    touchUp(8)

    mSleep(2076);
    touchDown(9, 350, 902)
    mSleep(161);
    touchUp(9)
    mSleep(1000);
    --进入“所有联系人”页面
--    if true == is_delete_contact then
--        page_array["page_suoyoulianxiren_del"]:enter(); --清除所有联系人
--    else
        page_array["page_suoyoulianxiren"]:enter(); --添加联系人
--    end
    return true;
end

--step1 第一步进入当前页面
function main_page:enter()        --进入页面后的动作--
	keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(2000);
    if true == self.check_page(self) then
    	return self.action(self)
    else
    	error_info("进入主界面错误")
    	return false
    end

end

--step2 第二步检查当前页面
function main_page:check_page()  --检查是否是在当前页面--
    print("main_page:check_page");
    --print(self.page_name);
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_main() then 
            return true;
        else          
            try_time = try_time + 1;
        end
    end
    return false;
end

function main_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_main()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function main_page:action()
    return action_main_contact_opt();
end

page_array["page_main"] = main_page:new()
--end page_main.lua
------------------end:  ./page/page_main.lua-------------------------------------




----------------------begin:  ./page/page_suoyoulianxiren.lua---------------------------------
--begin page_suoyoulianxiren.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

default_suoyoulianxiren_page = {
	page_name = "suoyoulianxiren_page",
	page_image_path = nil
}

suoyoulianxiren_page = class_base_page:new(default_suoyoulianxiren_page);
local function touch_middle()
    rotateScreen(0);
    mSleep(1600);
    touchDown(4, 348, 896)
    mSleep(240);
    touchUp(4)
    mSleep(1000);
end
local function check_page_suoyoulianxiren( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 1, -6, 0xF7F7F7, 6, -7, 
    0x007AFF, 12, -7, 0xF7F7F7, 7, 6, 
    0x007AFF, 13, 5, 0xF7F7F7, 19, -1, 0x007AFF }, 
    90, 583, 74, 602, 87);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true;
    else
        return false;
    end
--[[
    x, y = findMultiColorInRegionFuzzy({ 0xF1F1F1, 5, -3, 0x878787, 13, -3, 
    0x000000, 30, -2, 0xF7F7F7, 37, -2, 
    0x000000, 52, -1, 0x000000, 44, 2, 0x000000 }, 
    90, 242, 80, 294, 85);

    if x ~= -1 and y ~= -1 then  -- 如果找到了
    end
    -- body
    ]]--
end

local function action_suoyoulianxiren_delete()     --执行这个页面的操作--
    print("suoyoulianxiren_del_page:check_page");
    --print(self.page_name)
    rotateScreen(0);
    mSleep(424);
    
    touchDown(3, 348, 898) --按中间的“通讯录”
    mSleep(153);
    touchUp(3)
    mSleep(1200);

    touchDown(5, 532, 278) --点击“名字”
    mSleep(127);
    touchUp(5);
    mSleep(1500);

    touchDown(2, 600, 42)  --点击编辑
    mSleep(159);
    touchUp(2)
    mSleep(1800);
    --进入“所有联系详情-编辑”页面
    page_array["page_lianxirenxiangqing_del"]:enter();
    return true;
end

local function action_suoyoulianxiren_add()     --执行这个页面的操作--
    print("suoyoulianxiren_page:check_page");
    --print(self.page_name)
    rotateScreen(0);
    mSleep(424);
    touchDown(3, 626, 58)
    mSleep(68);
    touchUp(3)
    mSleep(1000);
    page_array["page_xinlianxiren"]:enter();
    return true;
end

--step1
function suoyoulianxiren_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
    	return self.action(self)
    else
        error_info("进入所有联系人 界面错误")
        return false
    end

end

--step2
function suoyoulianxiren_page:check_page()  --检查是否是在当前页面--
    print("suoyoulianxiren_page:check_page");
    --print(self.page_name)
    --return check_page();
    local try_time = 1
    while 3 > try_time do
         mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_suoyoulianxiren() then 
            return true;
        else  
            try_time = try_time + 1;
        end
    end
    return false;
end

function suoyoulianxiren_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_suoyoulianxiren() ;
end

--step3  --最主要的工作都在这个里面
function suoyoulianxiren_page:action()     --执行这个页面的操作--
    --[[
    print("suoyoulianxiren_page:check_page");
    --print(self.page_name)
    rotateScreen(0);
    mSleep(424);
    touchDown(3, 626, 58)
    mSleep(68);
    touchUp(3)
    mSleep(1000);
    page_array["page_xinlianxiren"]:enter();
    return true;
    --]]
    if true == is_delete_contact then
        return action_suoyoulianxiren_delete();
    else
        return action_suoyoulianxiren_add();
    end
end

page_array["page_suoyoulianxiren"] = suoyoulianxiren_page:new()
--end page_suoyoulianxiren.lua

------------------end:  ./page/page_suoyoulianxiren.lua-------------------------------------




----------------------begin:  ./page/page_lianxirenxiangqing.lua---------------------------------
--begin page_lianxirenxiangqing_del.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

default_lianxirenxiangqing_page = {
	page_name = "lianxirenxiangqing_page",
	page_image_path = nil
}

lianxirenxiangqing_page = class_base_page:new(default_lianxirenxiangqing_page);
local function touch_middle()
    rotateScreen(0);
    mSleep(1600);
    touchDown(4, 348, 896)
    mSleep(240);
    touchUp(4)
    mSleep(1000);
end
local function check_page_lianxirenxiangqing( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 16, 1, 0x047CFF, 20, 1, 0x98C9FF, 29, 1, 0xFFFFFF, 45, 0, 0x5FABFF, 46, 6, 0xFFFFFF, 39, 11, 0xFFFFFF }, 90, 102, 186, 148, 197);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true;
    else
        return false;
    end
end


local function action_lianxirenxiangqing_delete()     --删除联系人操作--
    print("lianxirenxiangqing_page:check_page");
    --print(self.page_name)

    -----------滑倒最下面----
    touchDown(3, 406, 760)
    mSleep(7);
    touchMove(3, 410, 742)
    mSleep(36);
    touchMove(3, 410, 722)
    mSleep(2);
    touchMove(3, 410, 698)
    mSleep(30);
    touchMove(3, 412, 662)
    mSleep(1);
    touchMove(3, 414, 612)
    mSleep(162);
    touchMove(3, 416, 556)
    mSleep(3);
    touchMove(3, 422, 498)
    mSleep(2);
    touchMove(3, 426, 422)
    mSleep(2);
    touchMove(3, 434, 348)
    mSleep(2);
    touchMove(3, 446, 276)
    mSleep(14);
    touchMove(3, 456, 208)
    mSleep(2);
    touchMove(3, 468, 142)
    mSleep(16);
    touchMove(3, 482, 88)
    mSleep(17);
    touchUp(3)

    mSleep(1239);
    touchDown(5, 430, 614)
    mSleep(1);
    touchMove(5, 432, 594)
    mSleep(2);
    touchMove(5, 432, 562)
    mSleep(6);
    touchMove(5, 438, 534)
    mSleep(2);
    touchMove(5, 444, 492)
    mSleep(34);
    touchMove(5, 450, 450)
    mSleep(15);
    touchMove(5, 454, 402)
    mSleep(1);
    touchMove(5, 460, 352)
    mSleep(34);
    touchMove(5, 466, 298)
    mSleep(15);
    touchMove(5, 474, 234)
    mSleep(1);
    touchMove(5, 484, 176)
    mSleep(30);
    touchMove(5, 494, 118)
    mSleep(2);
    touchMove(5, 506, 60)
    mSleep(18);
    touchUp(5)

    mSleep(1236);
    touchDown(6, 458, 452)
    mSleep(1);
    touchMove(6, 458, 436)
    mSleep(47);
    touchMove(6, 458, 408)
    mSleep(14);
    touchMove(6, 462, 380)
    mSleep(2);
    touchMove(6, 468, 346)
    mSleep(1);
    touchMove(6, 476, 310)
    mSleep(15);
    touchMove(6, 482, 276)
    mSleep(34);
    touchMove(6, 490, 236)
    mSleep(25);
    touchMove(6, 502, 198)
    mSleep(2);
    touchUp(6)

    mSleep(1236);
    --[[
    touchDown(6, 458, 452)
    mSleep(1);
    touchMove(6, 458, 436)
    mSleep(47);
    touchMove(6, 458, 408)
    mSleep(14);
    touchMove(6, 462, 380)
    mSleep(2);
    touchMove(6, 468, 346)
    mSleep(1);
    touchMove(6, 476, 310)
    mSleep(15);
    touchMove(6, 482, 276)
    mSleep(34);
    touchMove(6, 490, 236)
    mSleep(25);
    touchMove(6, 502, 198)
    mSleep(2);
    touchUp(6)
    mSleep(1024);
]]--
       
    touchDown(1, 294, 722) --删除联系人
    mSleep(100);
    touchUp(1)
    mSleep(1019);  ---确认删除
    touchDown(9, 426, 792)
    mSleep(71);
    touchUp(9)
    mSleep(1200);
    --进入“所有联系人”页面
    page_array["page_suoyoulianxiren"]:enter();
    return true;
end

--step1
function lianxirenxiangqing_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
    	return self.action(self)
    else
        error_info("进入联系人详情 界面错误")
        return false
    end

end

--step2
function lianxirenxiangqing_page:check_page()  --检查是否是在当前页面--
    print("lianxirenxiangqing_page:check_page");
    --print(self.page_name)
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_lianxirenxiangqing() then 
            return true;
        else          
            try_time = try_time + 1;
        end
    end
    return false;
end

function lianxirenxiangqing_page:quick_check_page()  --检查是否是在当前页面--
    return check_page_lianxirenxiangqing()
end

--step3  --最主要的工作都在这个里面,做删除联系人的操作
function lianxirenxiangqing_page:action()
    return action_lianxirenxiangqing_delete();
end

page_array["page_lianxirenxiangqing"] = lianxirenxiangqing_page:new()

--end page_lianxirenxiangqing.lua
------------------end:  ./page/page_lianxirenxiangqing.lua-------------------------------------




----------------------begin:  ./page/page_xinlianxiren.lua---------------------------------
--begin page_xinlianxiren.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

default_xinlianxiren_page = {
	page_name = "xinlianxiren_page",
    myindex = 1;
	page_image_path = nil
}

xinlianxiren_page = class_base_page:new(default_xinlianxiren_page);

local function check_page_xinlianxiren( ... )
  x, y = findMultiColorInRegionFuzzy({ 0x575757, 16, 1, 0x4F4F4F, 22, -2, 0xF7F7F7, 39, -3, 0x000000, 47, -2, 0x000000, 63, -2, 0xF7F7F7, 73, -2, 0x424242, 99, -1, 0xF7F7F7, 110, 0, 0xAAAAAA }, 90, 258, 75, 368, 79);

    if x ~= -1 and y ~= -1 then  -- 如果找到了
         return true
     else
        return false
    end
end

local function action_xinlianxiren_add()     --添加新的联系人--
    print("xinlianxiren_page:check_page");
    --print(self.page_name)
    my_name, my_number = generate_contact_info(); --产生随机的信息
     
    rotateScreen(0);
    mSleep(1233);
    touchDown(8, 370, 150)
    mSleep(573);
    touchMove(8, 368, 148)
    mSleep(1);
    touchMove(8, 370, 148)
    mSleep(1);
    touchUp(8)
    mSleep(1514)
    --设置名字
    inputText(my_name);
    mSleep(824);
    
    touchDown(5, 350, 470)
    mSleep(86);
    touchMove(5, 352, 462)
    mSleep(14);
    touchMove(5, 352, 454)
    mSleep(65);
    touchMove(5, 352, 450)
    mSleep(2);
    touchMove(5, 352, 444)
    mSleep(1);
    touchMove(5, 352, 440)
    mSleep(1);
    touchMove(5, 354, 436)
    mSleep(48);
    touchMove(5, 354, 432)
    mSleep(3);
    touchMove(5, 356, 428)
    mSleep(36);
    touchMove(5, 356, 422)
    mSleep(7);
    touchMove(5, 358, 416)
    mSleep(2);
    touchMove(5, 358, 412)
    mSleep(3);
    touchMove(5, 360, 408)
    mSleep(17);
    touchMove(5, 360, 404)
    mSleep(19);
    touchMove(5, 362, 396)
    mSleep(15);
    touchMove(5, 362, 390)
    mSleep(9);
    touchMove(5, 364, 382)
    mSleep(23);
    touchMove(5, 364, 376)
    mSleep(15);
    touchMove(5, 366, 370)
    mSleep(16);
    touchMove(5, 368, 362)
    mSleep(9);
    touchMove(5, 368, 356)
    mSleep(23);
    touchMove(5, 370, 350)
    mSleep(16);
    touchMove(5, 372, 346)
    mSleep(8);
    touchMove(5, 372, 344)
    mSleep(16);
    touchMove(5, 374, 340)
    mSleep(15);
    touchMove(5, 376, 336)
    mSleep(17);
    touchMove(5, 376, 334)
    mSleep(18);
    touchMove(5, 378, 330)
    mSleep(14);
    touchMove(5, 380, 328)
    mSleep(15);
    touchMove(5, 382, 324)
    mSleep(154);
    touchMove(5, 384, 318)
    mSleep(10);
    touchMove(5, 386, 314)
    mSleep(4);
    touchMove(5, 386, 308)
    mSleep(33);
    touchMove(5, 388, 302)
    mSleep(2);
    touchMove(5, 390, 298)
    mSleep(16);
    touchMove(5, 394, 290)
    mSleep(9);
    touchMove(5, 394, 284)
    mSleep(1);
    touchMove(5, 396, 280)
    mSleep(70);
    touchMove(5, 396, 278)
    mSleep(60);
    touchMove(5, 398, 274)
    mSleep(45);
    touchMove(5, 398, 270)
    mSleep(16);
    touchMove(5, 400, 266)
    mSleep(1);
    touchMove(5, 400, 262)
    mSleep(12);
    touchMove(5, 402, 260)
    mSleep(5);
    touchMove(5, 402, 256)
    mSleep(2);
    touchMove(5, 404, 254)
    mSleep(2);
    touchMove(5, 404, 252)
    mSleep(1);
    touchMove(5, 404, 250)
    mSleep(4);
    touchMove(5, 404, 250)
    mSleep(1);
    touchMove(5, 406, 248)
    mSleep(1);
    touchMove(5, 406, 246)
    mSleep(1);
    touchMove(5, 406, 244)
    mSleep(6);
    touchMove(5, 406, 242)
    mSleep(1);
    touchMove(5, 406, 242)
    mSleep(2);
    touchMove(5, 406, 240)
    mSleep(9);
    touchMove(5, 406, 240)
    mSleep(18);
    touchMove(5, 408, 240)
    mSleep(79);
    touchUp(5)
    
    
    mSleep(1599);
    
    touchDown(7, 70, 294)
    mSleep(207);
    touchUp(7)
    mSleep(1032);
     
   --设置电话号码
    inputText(my_number);
    mSleep(1032);
    
    touchDown(4, 628, 60)
    mSleep(179);
    touchUp(4)
    mSleep(3075);
    
    touchDown(6, 178, 50)
    mSleep(186);
    touchUp(6)
    mSleep(1000);
    --page_array["page_suoyoulianxiren"]:enter();
    return true;
end

--step1

function xinlianxiren_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
    	return self.action(self)
    else
        error_info("进入新联系人 界面错误")
    	return false
    end
end

--step2
function xinlianxiren_page:check_page()  --检查是否是在当前页面--
    print("xinlianxiren_page:check_page");
    --print(self.page_name)
--    return check_page();
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xinlianxiren() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xinlianxiren_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xinlianxiren();     
end

--step3  --最主要的工作都在这个里面
function xinlianxiren_page:action()
    return action_xinlianxiren_add();
end

page_array["page_xinlianxiren"] =  xinlianxiren_page:new()

--end page_xinlianxiren.lua
------------------end:  ./page/page_xinlianxiren.lua-------------------------------------




----------------------begin:  func_phone_book_opt.lua---------------------------------
--文件以"func_" 开头,说明是一个功能性的脚本
--此功能是： 电话簿联系人操作，根据输入的参数，来添加或删除联系人

function generate_contact_info() --产生随机号码
    local  x = math.random(99999);
    local  xx = pre_fix_phone_numb[math.random(#pre_fix_phone_numb)]
    x = (xx * 100000) + x

    local  y = tostring(x)
    y = string.sub(y, -3, -1)

    local my_name = pre_fix_name[math.random(#pre_fix_name)] .. y
    x = tostring(x)
    --print(x)
    --print(my_name)
    return my_name, x;
    -- body
end

function add_contact_init()
end

function run_add_contact()
end

function rmv_all_contact()
end

function auto_create_name(name)
end

function main_contact_opt() --添加或删除联系人主函数
    ---mSleep(10000);
	logFileInit(sl_log_file);
    local current_page = get_current_page(); --得到当前的page
    if false ~= current_page then 
       page_array[current_page]:enter(); --直接进当前页面的处理
    else
	   page_array["page_main"]:enter();
    end
end

--功能性脚本的入口程序，使用dofile调用
--在调试的时候，使用main函数封装，才能运行
    -- body
main_contact_opt();



--for i=1,20 do
--  generate_contact_info();
--end


------------------end:  func_phone_book_opt.lua-------------------------------------
