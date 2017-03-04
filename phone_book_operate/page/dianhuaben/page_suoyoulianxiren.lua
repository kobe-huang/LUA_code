--begin page_suoyoulianxiren.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

default_suoyoulianxiren_page = {
	page_name = "suoyoulianxiren_page",
	page_image_path = nil
}

suoyoulianxiren_page = class_base_page:new(default_suoyoulianxiren_page);

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

local function is_exsist_contact( ... ) --在做删除操作的时候。判断是否有通讯录
    -- body
    x, y = findMultiColorInRegionFuzzy({ 0xCCCCCC, 4, 0, 0xFFFFFF, 8, 1, 
        0xCCCCCC, 11, 1, 0xCCCCCC, 15, -2, 
        0xCCCCCC, 20, 1, 0xCCCCCC, 38, 2, 
        0xCCCCCC, 47, 0, 0xCCCCCC }, 
        90, 289, 696, 336, 700);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true;
    else
        return false;
    end
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
    page_array["page_lianxirenxiangqing"]:enter();
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
        --error_info("进入所有联系人 界面错误")
        self:error_handling();
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
        if true == is_exsist_contact() then
            warning_info("联系人已经删完");         
            return true;
        else
            return action_suoyoulianxiren_delete();
        end
    else
        return action_suoyoulianxiren_add();
    end
end

page_array["page_suoyoulianxiren"] = suoyoulianxiren_page:new()
--end page_suoyoulianxiren.lua
