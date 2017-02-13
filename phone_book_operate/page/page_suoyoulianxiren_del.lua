--begin page_suoyoulianxiren_del.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

default_suoyoulianxiren_del_page = {
	page_name = "suoyoulianxiren_del_page",
	page_image_path = nil
}

suoyoulianxiren_del_page = class_base_page:new(default_suoyoulianxiren_del_page);
local function touch_middle()
    rotateScreen(0);
    mSleep(1600);
    touchDown(4, 348, 896)
    mSleep(240);
    touchUp(4)
    mSleep(1000);
end
local function check_page_suoyoulianxiren_del( ... )
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

--step1
function suoyoulianxiren_del_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
    	return self.action(self)
    else
        error_info("进入所有联系人 界面错误")
        return false
    end

end

--step2
function suoyoulianxiren_del_page:check_page()  --检查是否是在当前页面--
    print("suoyoulianxiren_del_page:check_page");
    print(self.page_name)
    --return check_page();
    local try_time = 1
    while 3 < try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_suoyoulianxiren_del() then 
            return true;
        else           
            try_time = try_time + 1;
        end
    end
    return false;
end

function suoyoulianxiren_del_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_suoyoulianxiren_del();
end

--step3  --最主要的工作都在这个里面
function suoyoulianxiren_del_page:action()     --执行这个页面的操作--
    print("suoyoulianxiren_del_page:check_page");
    print(self.page_name)
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

page_array["page_suoyoulianxiren_del"] = suoyoulianxiren_del_page:new()
--end page_suoyoulianxiren_del.lua