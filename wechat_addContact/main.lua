--全局变量--begin
package.path=package.path .. ";/private/var/touchelf/scripts/?.lua"
log_file_name = "/private/var/touchelf/scripts/contact/contact_shot/error_log.log"             -- 每日加的信息log
log_file_handle = nil                   -- log文件句柄

interval_time = 10*1000;                -- 每次执行的间隔时间 

contact_fix_path = "/private/var/touchelf/scripts/contact/";     -- 个人信息的存放地址
contact_fix_dir_name  = "_card";        -- 名字
contact_pre_fix_name = "_card_";        -- 名字

contact_MD5_index_file = "MD5.txt"      -- 做匹配用
contact_MD5_file_handle = nil;
contact_index_file = "/private/var/touchelf/scripts/contact/contact_shot/contact_index.txt"

max_days_add_num  = 40                  -- 每天最多加的粉丝
page_mov_distance = 100;                -- 单屏划动的距离
card_interval_distance = 50;            -- 2个卡片间隔的距离
start_point = {x = 0, y = 0};           -- 起始点
point_return = {x = 82, y = 82};        --- 左上角 “返回”

rightnow_data = "20161103"
rightnow_time = "211203"

screen_info = { width = 640, height = 1136, grid = 80, color = 555 };  --屏幕信息
--全局变量--end

point_array = {};
function init_point(b)
    if b.name then
        --notifyMessage(b.name .. "__XXXX");
        point_array[b.name] = {}
        point_array[b.name].x = b.x;
        point_array[b.name].y = b.y;
    end
end

--这里balance是一个公有的成员变量。
local class_part_screenshot = {
    shot_name = "default_shot", 
    shot_path = "/private/var/touchelf/scripts/contact/res/part_shot/default_shot.bmp", 
    shot_area = { shot_start_point_X=0, shot_start_point_Y=0, shot_width = 0, shot_height = 0 } 
};

function class_part_screenshot:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。 
    setmetatable(o,self)
    self.__index = self
    --最后返回构造后的对象实例
    return o
end
--
part_screenshot_array = {}
function init_part_screenshot(b) 
    --这里将table对象b的name字段值作为personInfo的key信息。
    if b.shot_name then
        part_screenshot_array[b.shot_name] =  class_part_screenshot:new(b);
    end
end
-------

----------------------------------------------------------------------------------------------------------------------------------------------base_page--
class_base_page = {
    page_name = "default_page", 
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/default_page.bmp",
   -- page_snap_iamge = {} --截图数组，hash数组
} 

function class_base_page:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    return o    --最后返回构造后的对象实例
end

function class_base_page:action()  --页面的动作---
    print("class_base_page:action");
    print(self.page_name);
end
--
function class_base_page:check_page()  --检查是否是在当前页面--
    print("class_base_page:check_page");
    print(self.page_name)
    return true;
end
--
function class_base_page:getPageName()
    return self.page_name;
end
--
page_array = {}
function init_page(b)    
    if b.page_name then --这里将table对象b的name字段值作为personInfo的key信息。
        page_array[b.page_name] = class_base_page:new(b);
    end
end

-------------------------------------------------------------------------------------------------------初始化--------------------------------------
dofile("/private/var/touchelf/scripts/data.lua");
require "touch_action"
require "page_stack"
require "file"
--begein-require "page"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----检查是否之前已经添加过---- 
--每一个界面做成一个对象，利用OOB来做

function save_card_info(file_name, x, y, xx, yy, mystring,file_name1) --保存联系人信息--
    snapshotRegion(file_name, x, y, xx, yy); -- 将区域[(100,100)(200,200)]的截图保存到路径为/mnt/sdcard/a.bmp的图片中, 格式为BMP
    writeStrToFile(mystring,file_name1)
end
--

function getPicKeyInfo(x, y) --得到关键信息--
    local file_name = "/private/var/touchelf/scripts/contact/contact_shot/temp_XXXX.bmp"
    snapshotRegion(file_name, x, y, x+80, y); 
    return fileToHexString(file_name);
end

function check_card_is_repeated(x, y)  --检查是否是重复的联系人  文件和查找的点---
    local card_info = getPicKeyInfo(x, y);
    if true ==  isStringInFile(card_info, contact_index_file) then
        return true;
    else
        return card_info;
    end    
end
--
--进入某个page界面--进入失败 返回false--
function enter_page(page_name) --page 入栈
    --入栈
    mSleep(1200) --先等待一下
    if true == page_array[page_name]:check_page() then
        page_stack:push(page_name);
        return true;
    else
        --notifyMessage("can't enter page" .. page_name);
        return false;
    end
end

function outof_page()       ----出栈
    --出栈
   return page_stack:pop();   
end
---
function init_page_stack()  --初始化堆栈
    page_stack = class_page_stack:new();
end


---检查当前图片是否匹配--
function check_shot_is_match(shot_name, isFuzz)  ----默认是模糊查找
    if type(shot_name) ~= "string"  or nil == part_screenshot_array[shot_name] then
        return false
    end
    local x = 0;
    local y = 0;
    
    if 0 == part_screenshot_array[shot_name].shot_area.shot_start_point_X and 0 == part_screenshot_array[shot_name].shot_area.shot_end_point_X then
        if isFuzz == nil then 
            x, y = findImageFuzzy(part_screenshot_array[shot_name].shot_path, 90, 0x000000);
        else
            x, y = findImage(part_screenshot_array[shot_name].shot_path);
        end   
        -- 在全屏范围找到第一个路径为"/mnt/sdcar/a.bmp"的图片, 精确度为90, 忽略图片中颜色为0x000000（黑色）的点, 将其左上角坐标保存到变量x和y中
        if x ~= -1 and y ~= -1 then -- 如果找到了
            return x, y;
        else 
            print("不能找到: " .. shot_name)
            return -1, -1;
        end
    else --局部匹配
        --mSleep(30);  
        if isFuzz == nil then 
            x, y = findImageInRegionFuzzy( part_screenshot_array[shot_name].shot_path,
                90,
                part_screenshot_array[shot_name].shot_area.shot_start_point_X,
                part_screenshot_array[shot_name].shot_area.shot_start_point_Y,
                part_screenshot_array[shot_name].shot_area.shot_end_point_X,
                part_screenshot_array[shot_name].shot_area.shot_end_point_Y, 0x000000);  
        else
            x, y = findImageInRegion( part_screenshot_array[shot_name].shot_path,
                part_screenshot_array[shot_name].shot_area.shot_start_point_X,
                part_screenshot_array[shot_name].shot_area.shot_start_point_Y,
                part_screenshot_array[shot_name].shot_area.shot_end_point_X,
                part_screenshot_array[shot_name].shot_area.shot_end_point_Y, 0x000000); 
        end
       
        if x ~= -1 and y ~= -1 then
            return x, y;   --- 如果找到了
        else
            print("不能找到: " .. shot_name)
            return -1, -1;
        end 
    end
end
--

-----------------------------------------------------------------------------------------------------------------------------------------微信列表 page----
class_weixin_liebiao_page = class_base_page:new();
class_weixin_liebiao_page.card_index = 0;
function class_weixin_liebiao_page:check_page()
    local x; local y;
    x, y = check_shot_is_match("wenzi_weixin1");
    if -1 ~= x then
        return true;
    else
        return false;
    end
end

function class_weixin_liebiao_page:action()  ---动作---
    local x = 0; local y =0; local _=0;   
    
    for _=1, 20 do    ---- 往上翻到底
        move_down();
        mSleep(20)
    end
    mSleep(1000);
    
    for i = 1, 4 do  --往上翻3次--
        x,y = check_shot_is_match("tupian_qunmingcheng1", false );
        if -1 == x or -1 == y then
            move_up();
        else
            x = (x + 50);
            y = (y + 25);
            click( x, y); --进入聊天界面--
            mSleep(300);
            if false == enter_page("liaotianzhujiemian") then
                error_info("进入群聊天界面失败")
            end
            return; --要返回的
        end
    end
    error_info("+++找不到要进入的群++++");
end
----------------------------------------------------------------------------------------------------------------------------------------群聊天 page----

class_liaotianzhujiemian_page = class_base_page:new();
class_liaotianzhujiemian_page.card_index = 0;   --默认的索引
class_liaotianzhujiemian_page.page_index = 0;   --默认的索引
function class_liaotianzhujiemian_page:check_page()
    local  x = check_shot_is_match("wenzi_weixin");
    if -1 ~= x then
        local y = check_shot_is_match("tupian_qunmingcheng");
        if -1 ~= y then
             return true;
         else
             return false;
         end
    else
        return false;
    end
end

function class_liaotianzhujiemian_page:action() ---动作---
    if self.card_index == 0 and self.page_index ==0 then
        local _ =0;
        for _=1, 3 do
            move_up();
            mSleep(300);
        end
    end
    
    if ( self.card_index == 9 ) then  --0~3
        self.page_index = (self.page_index + 1) % 4  --只翻5页&5次
        if self.page_index == 0 then
            self.page_index = 0;
            self.card_index = 0;
            init_page_stack(); ---清空所有的信息---------------------------------终结者------------------
            return;
        end       
        move_down_page();  ---往上翻页--
        --move_down();
    end
    self.card_index = self.card_index % 9;
    local x = 320; local y = (point_array["liaotian_end"].y - (self.card_index*100) ); --1020 --160  --每一小格子为 60
    self.card_index = self.card_index + 1;
    click(x, y); --点击屏幕
    mSleep(1000);
       
    if false == enter_page("xiangxi_ziliao") then
        if true == self:check_page() then  --如果点到空气
            self:action();  --重新进入处理
        else
            click_point("fanhui"); ---比如进网页，则点返回
            mSleep(1000);
            if true == self:check_page() then
               self:action();  --重新进入处理
            else
                error_info("鬼知道点到了什么");
            end      
        end      
    end
end

----------------------------------------------------------------------------------------------------------------------------------详细信息-添加到通讯录---
class_xiangxi_ziliao_page = class_base_page:new();
class_xiangxi_ziliao_page.point_y = 785;  --点击添加到通讯录时的Y坐标
function class_xiangxi_ziliao_page:check_page()
    local x = check_shot_is_match("wenzi_xiangxiziliao"); 
    local y = 0
    if -1 ~= x then
       x, y = check_shot_is_match("wenzi_tianjia_tongxunlu"); 
       if -1 ~= y then
           self.point_y = y + 4;
           return true
       else
           return false
       end
    else
        return false;
    end
end

function class_xiangxi_ziliao_page:action()  ---动作---
    local x = point_array["tianjia_dao_tongxunlu"].x;
    local y = self.point_y;  --point_array["tianjia_dao_tongxunlu"].y;
    
    local check_result = check_card_is_repeated(point_array["guanjiandian"].x, point_array["guanjiandian"].y);
    if true  == check_result then
        click_point("fanhui");             --返回
        enter_page("liaotianzhujiemian");  --返回聊天界面--
        --outof_page();
    else
        --local my_data = os.date("%Y%m%d");                 --得到当前日期和时间
        --local my_time = os.date("%H-%M-%S");
        --local fileName = string.format("%s.jpg",os.time()); --保存为jpg格式的截图
        local fileName = string.format("%s_%s.jpg",os.date("%Y%m%d"),os.date("%H-%M-%S") ); --保存为jpg格式的截图
        local myFileName = "/private/var/touchelf/scripts/contact/contact_shot/" .. fileName;
        check_result = fileName .. "  " .. check_result;
        save_card_info(myFileName, 
            part_screenshot_array["tupian_lianxiren_jietu"].shot_area.shot_start_point_X,
            part_screenshot_array["tupian_lianxiren_jietu"].shot_area.shot_start_point_Y,
            part_screenshot_array["tupian_lianxiren_jietu"].shot_area.shot_end_point_X,
            part_screenshot_array["tupian_lianxiren_jietu"].shot_area.shot_end_point_Y,
            check_result,
            contact_index_file
            );       
        click(x, y); --点击添加联系人
        mSleep(2000);
        if false  == enter_page("xiangxi_ziliao1") then    --进入详细资料--打招呼界面
            click_point("fanhui");
            mSleep(1000);
            click_point("fanhui");
            if false == enter_page("liaotianzhujiemian") then  --返回到聊天主界面
                error_info("添加联系人失败，返回聊天界面也失败");
            end
        end
    end
end



------------------------------------------------------------------------------------------------------------------------------------详细信息1-打招呼---

class_xiangxi_ziliao1_page = class_base_page:new();
class_xiangxi_ziliao1_page.point_y = 930;
class_xiangxi_ziliao1_page.isReturn = false;
function class_xiangxi_ziliao1_page:check_page()
    local x = check_shot_is_match("wenzi_xiangxiziliao");
    local y = 0;
    if -1 ~= x then
        x, y = check_shot_is_match("wenzi_dazhaohu") ;
        if  -1 ~= y then
            self.point_y = y + 4;
            return true;
        else
            return false;
        end
    else
        return false;
    end
end

function class_xiangxi_ziliao1_page:action()  ---动作---
    if false == self.isReturn then
        local x = point_array["dazhaohu"].x;
        local y = self.point_y;--point_array["dazhaohu"].y;
        click(x, y);
        mSleep(1000);
        if false == enter_page("liaotianzhujiemian1") then
            error_info("打招呼失败");
        end
    else
        click_point("fanhui"); mSleep(500);
        --outof_page();
        if false == enter_page("liaotianzhujiemian") then  --返回到群聊天主界面
            error_info("添加名片后，返回时失败");
        end
        
    end
end


----------------------------------------------------------------------------------------------------------------------------------------聊天界面-个人----

class_liaotianzhujiemian1_page = class_base_page:new();
function class_liaotianzhujiemian1_page:check_page()
     --mSleep(600);
     return true;
end

function class_liaotianzhujiemian1_page:action()  ---动作---
    local x = point_array["fanhui"].x;
    local y = point_array["fanhui"].y;
    click(x, y);  --返回到 weixin_liebiao.bmp 界面
    mSleep(1000);
    if false == enter_page("weixin_liebiao") then
        error_info("返回联系人列表失败");
    end
    --outof_page();
end


------------------------------------------------------------------------------------------------------------------------------------------------------

---end-require "page"-+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--notifyMessage("添加文件完成");
--mSleep(1000);

page_array["weixin_liebiao"] = class_weixin_liebiao_page:new(
    { page_name = page_array["weixin_liebiao"].page_name, 
    page_image_path = page_array["weixin_liebiao"].page_image_path,
    card_index = 0} );

page_array["liaotianzhujiemian"] = class_liaotianzhujiemian_page:new(
    {page_name = page_array["liaotianzhujiemian"].page_name,
    page_image_path = page_array["liaotianzhujiemian"].page_image_path,
    card_index = 0, page_index =0} );

page_array["xiangxi_ziliao"] = class_xiangxi_ziliao_page:new(
    {page_name = page_array["xiangxi_ziliao"].page_name,
    page_image_path = page_array["xiangxi_ziliao"].page_image_path,
    card_index = 0} );

page_array["xiangxi_ziliao1"] = class_xiangxi_ziliao1_page:new(
    {page_name = page_array["xiangxi_ziliao1"].page_name,
    page_image_path = page_array["xiangxi_ziliao1"].page_image_path,
    card_index = 0 });

page_array["liaotianzhujiemian1"] = class_liaotianzhujiemian1_page:new(
    {page_name = page_array["liaotianzhujiemian1"].page_name,
    page_image_path = page_array["liaotianzhujiemian1"].page_image_path,
    card_index = 0} );


function check_environment()
    --得到当前设备信息
    screen_info.width, screen_info.height = getScreenResolution(); 
    screen_info.color = getScreenColorBits();
    if screen_info.width == 640 and screen_info.height == 1136 then
    --notifyMessage("当前设备为iphone5")
        print("XXXXX");
    else
        error_info("请在iphone5c上使用本程序");
    end    
     rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
     rightnow_time = os.date("%H:%M:%S");
     
     --建立log文件--
     --log_file_handle = assert(io.open(log_file_data_name, "a"));
     --log_file_handle = assert(io.open(log_file_data_name, "a"));
     --contact_MD5_file_handle = assert(io.open(MD5_file_name, "w"));
     
    if false == file_exists(contact_fix_path .. "contact_shot/") then  --创建自己的临时文件夹
          os.execute("mkdir -p " .. contact_fix_path .. "contact_shot/");
          --local file = io.open(contact_fix_path .. log_file ,"w")
    end
   
 end

function enter_chat_page() --进入聊天界面---
    --判断是不是在微  --判断是否在微信界面--然后进入微信界面--
    appRun("com.tencent.xin");  --启动微信
    if appRunning("com.tencent.xin") then
        --notifyMessage("yes");
    else
       notifyMessage("无法启动微信");
       mSleep(5000);
       os.exit(1);
    end
    
    local log_file_data_name =  contact_fix_path .. rightnow_data .. log_file_name;
    local MD5_file_name = contact_fix_path .. contact_MD5_index_file;
     writeStrToFile(rightnow_data .. " " .. rightnow_time .. "   +++begin+++", contact_index_file);
   --微信聊天界面--  
    local x = -1; local  y = -1; local i = 1;
    if true == page_array["liaotianzhujiemian"]:check_page() then --检查是否在 群聊天界面
        --do nothing
         if false == enter_page("liaotianzhujiemian")  then --进入聊天主界面--
            error_info("进入聊天界面失败");
         end
         mSleep(200);
         return;
    else
        for i = 1, 4 do 
            click_point("fanhui");      ---连续按几次返回
            mSleep(300);
        end 
        click_point("weixin_anjian");  --点击，左下方的”微信界面“
        if false == enter_page("weixin_liebiao") then  --进入微信列表界面--
            error_info("进入微信列表失败")
        end
    end    
end
--
function reset_function()
     page_array["weixin_liebiao"] = class_weixin_liebiao_page:new(
        { page_name = page_array["weixin_liebiao"].page_name, 
        page_image_path = page_array["weixin_liebiao"].page_image_path,
        card_index = 0} );

    page_array["liaotianzhujiemian"] = class_liaotianzhujiemian_page:new(
        {page_name = page_array["liaotianzhujiemian"].page_name,
        page_image_path = page_array["liaotianzhujiemian"].page_image_path,
        card_index = 0, page_index =0} );

    page_array["xiangxi_ziliao"] = class_xiangxi_ziliao_page:new(
        {page_name = page_array["xiangxi_ziliao"].page_name,
        page_image_path = page_array["xiangxi_ziliao"].page_image_path,
        card_index = 0} );

    page_array["xiangxi_ziliao1"] = class_xiangxi_ziliao1_page:new(
        {page_name = page_array["xiangxi_ziliao1"].page_name,
        page_image_path = page_array["xiangxi_ziliao1"].page_image_path,
        card_index = 0 });

    page_array["liaotianzhujiemian1"] = class_liaotianzhujiemian1_page:new(
        {page_name = page_array["liaotianzhujiemian1"].page_name,
        page_image_path = page_array["liaotianzhujiemian1"].page_image_path,
        card_index = 0} ); 
    init_page_stack();
end

function run_function()
     while true do
       enter_chat_page();
       local now_page_name = outof_page();
       
       while nil ~= now_page_name do
           page_array[now_page_name]:action();  --执行相关的操作
           now_page_name = outof_page();
       end 
        rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
        rightnow_time = os.date("%H:%M:%S");
        writeStrToFile(rightnow_data .. " " .. rightnow_time .. "   +++again+++", contact_index_file);
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(60000);      --每隔五分钟执行一次
   end
end


function main()
   --notifyMessage("main 开始执行");
   check_environment();
   run_function();
   --error_info("++++main 执行完毕++++");
end
