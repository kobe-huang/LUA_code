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

function check_card_is_repeated(contact_index_file, x, y)  --检查是否是重复的联系人  文件和查找的点---
    local card_info = getPicKeyInfo(x, y);
    if true ==  isStringInFile(card_info, contact_index_file) then
        return true;
    else
        return card_info;
    end    
end
--
--进入某个page界面
function enter_page(page_name)
    --入栈
    if true == page_array[page_name]:check_page() then
        page_stack.push(page_name);
        page_array[page_name]:action();
    else
        notifyMessage("can't enter page" .. page_name);
    end
    
end

function outof_page(page_name)
    --出栈
    page_stack.pop();   
end
---

---检查当前图片是否匹配--
function check_shot_is_match(shot_name)
    if type(shot_name) ~= "string"  or nil == part_screenshot_array[shot_name] then
        return false
    end
    local x = 0;
    local y = 0;
    
    if 0 == part_screenshot_array[shot_name].shot_start_point_X and 0 == part_screenshot_array[shot_name].shot_end_point_X then
        x, y = findImageFuzzy(part_screenshot_array[shot_name].shot_path, 90, 0x000000); 
        -- 在全屏范围找到第一个路径为"/mnt/sdcar/a.bmp"的图片, 精确度为90, 忽略图片中颜色为0x000000（黑色）的点, 将其左上角坐标保存到变量x和y中
        if x ~= -1 and y ~= -1 then                              -- 如果找到了
            --touchDown(0, x, y);                                -- 点击那个点
            --touchUp(0);
            return x, y;
        else 
            return -1, -1;
        end
    else --局部匹配
        x, y = findImageInRegionFuzzy(part_screenshot_array[shot_name].shot_path,
            90, part_screenshot_array[shot_name].shot_start_point_X, part_screenshot_array[shot_name].shot_start_point_Y, 
            part_screenshot_array[shot_name].shot_send_point_X, part_screenshot_array[shot_name].shot_end_point_Y, 0x000000);    
        if x ~= -1 and y ~= -1 then
            return 1, 1;-- 如果找到了
        else
            --notifyMessage("请进入聊天界面后再执行");
            --mSleep(5000);
            --os.exit();
            return -1, -1;
        end 
    end
end
--

---------------------------------------------------------------------------------------------------------------------------------微信列表 page----
class_weixin_liebiao_page = class_base_page:new();
class_weixin_liebiao_page.card_index = 0;
function class_weixin_liebiao_page:check_page()
    local x = check_shot_is_match("wenzhi_weixin1");
    if 1 == x then
        --do nothing
         mSleep(600);
         return true;
    else
        return false;
    end
end
function class_weixin_liebiao_page:action()  ---动作---
        for i = 1, 3 do  --往上翻3次--
            x,y = check_shot_is_match("tupian_qunmingcheng1")
            if -1 == x or -1 == y then
                move_up();
            else
                x = x + 50;
                y = y + 30;
                click( x, y); --进入聊天界面--
                mSleep(600);
                enter_page("class_liaotianzhujiemian_page");
                return;
            end
        end
        notifyMessage("+++找不到要进入的群++++");
        os.exit();
end
----------------------------------------------------------------------------------------------------------------------------------------群聊天 page----

class_liaotianzhujiemian_page = class_base_page:new();
class_liaotianzhujiemian_page.card_index = 1;
class_liaotianzhujiemian_page.page_index = 1;
function class_liaotianzhujiemian_page:check_page()
    local  x = check_shot_is_match("wenzi_weixin") ;
    local  y = check_shot_is_match("tupian_qunmingcheng");
    if 1 == x and  1 == y then
        --do nothing
         mSleep(600);
         return true;
    else
        return false;
    end
end
function class_liaotianzhujiemian_page:action()  ---动作---
    if self.card_index == 0 then
        if slef.page_index == 0 then
            return;
        end
        move_up();  ---往上翻页--
        slef.page_index =  (slef.page_index + 1)%4  --只翻4页
    end
    local y = (point_array[liaotian_front].y + self.card_index * 100); x = 320;
    click(x, y);
    enter_page("xiangxi_ziliao_page"); 
    self.card_index = (self.card_index + 1)%9
end
--------------------------------------------------------------------------------------------------------------------------------详细信息-添加到通讯录---

class_xiangxi_ziliao_page = class_base_page:new();
function class_xiangxi_ziliao_page:check_page()
    local x = check_shot_is_match("wenzhi_xiangxiziliao");
    local y = check_shot_is_match("wenzi_tianjia_tongxunlu");
    if 1 == x and  1 == y then
        --do nothing
         mSleep(600);
         return true;
    else
        return false;
    end
end
function class_xiangxi_ziliao_page:action()  ---动作---
    local x = point_array[tianjia_dao_tongxunlu].x;
    local y = point_array[tianjia_dao_tongxunlu].y;
    
    local check_result = check_card_is_repeated( point_array[guanjiandian].x, point_array[guanjiandian].y);
    if true  == check_result then
        click(point_array[fanhui].x, point_array[fanhui].y);
        enter_page("liaotianzhujiemian");  --返回聊天界面--
        outof_page();
    else
        local my_data = os.date("%Y%m%d");   --得到当前日期和时间
        local my_time = os.date("%H-%M-%S");
        local myFileName = string.format("/private/var/touchelf/scripts/contact/contact_shot/%s.bmp",os.time());
        check_result = myFileName .. check_result .. "\r\n"; 
        save_card_info(myFileName, 
            part_screenshot_array[tupian_lianxiren_jietu].shot_start_point_X,
            part_screenshot_array[tupian_lianxiren_jietu].shot_start_point_Y,
            part_screenshot_array[tupian_lianxiren_jietu].shot_end_point_X,
            part_screenshot_array[tupian_lianxiren_jietu].shot_end_point_Y,
            check_result,
            contact_index_file
            );
        
        click(x, y);
        mSleep(600);
        enter_page("xiangxi_ziliao1");
    end
end



------------------------------------------------------------------------------------------------------------------------------------详细信息1-打招呼---

class_xiangxi_ziliao1_page = class_base_page:new();
function class_xiangxi_ziliao1_page:check_page()
    local x = check_shot_is_match("wenzhi_xiangxiziliao");
    local y = check_shot_is_match("wenzi_dazhaohu") ;
    if 1 == x and  1 == y then
        --do nothing
         mSleep(600);
         return true;
    else
        return false;
    end
end
function class_xiangxi_ziliao1_page:action()  ---动作---
    local x = point_array[dazhaohu].x;
    local y = point_array[dazhaohu].y;
    click(x, y);
    mSleep(600);
    enter_page("liaotianzhujiemian1");
end


----------------------------------------------------------------------------------------------------------------------------------------聊天界面-个人----

class_liaotianzhujiemian1_page = class_base_page:new();
function class_liaotianzhujiemian1_page:check_page()
     mSleep(600);
     return true;
end

function class_liaotianzhujiemian1_page:action()  ---动作---
    local x = point_array[fanhui].x;
    local y = point_array[fanhui].y;
    click(x, y);  --返回到 weixin_liebiao.bmp 界面
    mSleep(600);
    enter_page("weixin_liebiao");
    outof_page();
end


------------------------------------------------------------------------------------------------------------------------------------------------------
