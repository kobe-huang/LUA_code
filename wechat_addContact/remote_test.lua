
--[[
local md5 = require "md5"
local result = md5.update("hello world")
print(result)
notifyMessage(result); --]]
myarray = {};
--myarray[huangyinke] = {0, 0, yin =1, keyDown=2}
--全局变量--begin
package.path=package.path .. ";/private/var/touchelf/scripts/?.lua"
require "touch_action"
require "page_stack"




function main()
    --check_shot_is_match("huhu");
    --check_shot_is_match("huhu",true);
    local size = 99;
    local myStr = "";
    size = page_stack:size();
    error_info("ceshicesh");
    page_stack:push("huangyinke")
    size = page_stack:size();
    page_stack:push("KKKKKK")
    size = page_stack:size();
    
    page_stack = class_page_stack:new();
    size = page_stack:size();
    
    
    myStr = page_stack:pop();
    size = page_stack:size();
    
    myStr = page_stack:pop();
    size = page_stack:size();
    
    myStr = page_stack:pop();
    size = page_stack:size();
end


function check_shot_is_match(shot_name, isFuzz)
    
    if isFuzz == nil then 
            print("YYY")
    else
            print("XXXX")
    end 
    print(shot_name);
    
end

function main_5()
    move_up();
    move_left();
    move_right();
    move_up();
    move_down();
end

function main_4()
   local x = 0;
   local y = 0;
   local time1 = os.time();
   --mSleep(5000);
   --keepScreen(true);
    --x, y = findImage("/private/var/touchelf/scripts/contact/res/screen_shot/tupian_qunmingcheng1.bmp");   -- 5~6
    --x, y = findImageFuzzy("/private/var/touchelf/scripts/contact/res/screen_shot/tupian_qunmingcheng1.bmp", 90, 0x000000); --15
    x, y = findImageInRegion("/private/var/touchelf/scripts/contact/res/screen_shot/tupian_qunmingcheng1.bmp",100,100,500, 1000, 0x000000);  --3
    --x, y = findImageInRegionFuzzy("/private/var/touchelf/scripts/contact/res/screen_shot/tupian_qunmingcheng1.bmp",90, 100,100,500, 1000, 0x000000); --7
   -- keepScreen(false);
   local time2 = os.time();
        -- 在全屏范围找到第一个路径为"/mnt/sdcar/a.bmp"的图片, 精确度为90, 忽略图片中颜色为0x000000（黑色）的点, 将其左上角坐标保存到变量x和y中
        if x ~= -1 and y ~= -1 then                              -- 如果找到了
            --touchDown(0, x, y);                                -- 点击那个点
            --touchUp(0);
            notifyMessage( time2 - time1);
            --mSleep(5000);
            return x, y;
        else 
            print("不能找到: " .. shot_name)
            notifyMessage( time2 -time1);
            return -1, -1;
        end
end

function main_3()
   local x = 0;
   local y = 0;
   x, y = findImageInRegionFuzzy("/private/var/touchelf/scripts/contact/res/screen_shot/wenzi_tianjia_tongxunlu.bmp",
            90, 160, 720, 
            460, 880, 0x000000); 
        print("XXXXXXXXXX");
        if x ~= -1 and y ~= -1 then
            return 1, 1;-- 如果找到了
        else
            --notifyMessage("请进入聊天界面后再执行");
            --mSleep(5000);
            --os.exit();
            notifyMessage("不能找到: " .. shot_name)
            return -1, -1;
        end 
end


function main_2()
    notifyMessage("huangyinkeXXX");
    os.execute("mkdir -p " .. "/private/var/touchelf/scripts/contact/tmp_pic/huangyinke" .. "/");
end
function main_1()
        notifyMessage("huangyinkeXXX");
        mSleep(3000);
        snapshotRegion("/private/var/touchelf/scripts/contact/tmp_pic/aq.bmp", 180, 208, 300, 208); 
        -- 将区域[(100,100)(200,200)]的截图保存到路径为/mnt/sdcard/a.bmp的图片中, 格式为BMP
        mSleep(100);
        snapshotRegion("/private/var/touchelf/scripts/contact/tmp_pic/bq.bmp", 300, 208, 300, 208); 
        
        str = fileToHexString("/private/var/touchelf/scripts/contact/tmp_pic/aq.bmp");
        notifyMessage(str);
        txt_file = io.open("/private/var/touchelf/scripts/contact/tmp_pic/list.txt", "a")
        txt_file:write("XXXX   ");
        txt_file:write(str .. "\r\n");
        txt_file:close(); 
        txt_file = io.open("/private/var/touchelf/scripts/contact/tmp_pic/list.txt", "a")
        txt_file:write("YYYY   ");
        txt_file:write(str .. "\r\n");
        txt_file:close(); 
        txt_file = io.open("/private/var/touchelf/scripts/contact/tmp_pic/list.txt", "a")
        txt_file:write("ZZZZ   ");
        txt_file:write(str  .. "\r\n");
        txt_file:close(); 
        
-- 将区域[(100,100)(200,200)]的截图保存到路径为/mnt/sdcard/a.jpg的图片中, 格式为JPG, 
--notifyMessage("huangyinkeYYY");

--bmp_file = io.open("/private/var/touchelf/scripts/contact/tmp_pic/aq.bmp", "r")
--txt_file = io.open("/private/var/touchelf/scripts/contact/tmp_pic/list.txt", "w")
--local ttt = bmp_file:read("*all")
--notifyMessage(ttt);
--txt_file:write(ttt);
--txt_file:close();
--bmp_file:close();
os.exit();
end
--os.exit();

--log_file_handle = io.open(log_file_data_name, "w"));


--并且尺寸缩小为原始尺寸的50%
    --snapshotScreen(string.format( "/mnt/sdcard/%s.bmp",os.time()), 100, 100, 200, 200); -- 以时间戳命名进行截图，防止截图重名被覆盖

--[[
Account = {balance = 0}

function Account:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    --将新对象实例的metatable指向Account表(类)，这样就可以将其视为模板了。
    setmetatable(o,self)
    --在将Account的__index字段指向自己，以便新对象在访问Account的函数和字段时，可被直接重定向。
    self.__index = self
    --最后返回构造后的对象实例
    return o
end
--
function main_test_class()
a = Account:new()
notifyMessage(a.balance);

Account.balance = 2;
notifyMessage(a.balance);

a.balance = 3;
notifyMessage(a.balance);

b = Account:new()
notifyMessage(b.balance);
end
--]]


function main_1()
    local i = -14;
    local n = math.modf(i/15);
    notifyMessage(n);
    if -0 == n then
        notifyMessage("hello");
    end
    
end


table_test = { start = "开始++", myend = "结束++" };
function main_1()
    print("hello world");
    mystring = "start";
    notifyMessage( table_test[mystring] );
    --mSleep(5000);
    --myAppName = frontAppBid();
    --notifyMessage(myAppName);
    --mSleep(5000);
    --version = getVersion(); -- 将触摸精灵版本号保存在变量version中
    --notifyMessage(version); -- 显示版本号
   --[[ path = appBundlePath("com.tencent.xin")
    if path ~= "" then
        notifyMessage(path);
    else
        notifyMessage("no");
    end
    mSleep(5000);
    --]]
    --shakeDevice()
    --判断是否在微信界面--
    --[[
    appRun("com.tencent.xin");  --启动微信
    if appRunning("com.tencent.xin") then
        --notifyMessage("yes");
    else
        notifyMessage("无法启动微信");
    end
    --]]
end