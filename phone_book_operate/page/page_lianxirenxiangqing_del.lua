--begin page_lianxirenxiangqing_del.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

default_lianxirenxiangqing_del_page = {
	page_name = "lianxirenxiangqing_del_page",
	page_image_path = nil
}

lianxirenxiangqing_del_page = class_base_page:new(default_lianxirenxiangqing_del_page);
local function touch_middle()
    rotateScreen(0);
    mSleep(1600);
    touchDown(4, 348, 896)
    mSleep(240);
    touchUp(4)
    mSleep(1000);
end
local function check_page_lianxirenxiangqing_del( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 16, 1, 0x047CFF, 20, 1, 0x98C9FF, 29, 1, 0xFFFFFF, 45, 0, 0x5FABFF, 46, 6, 0xFFFFFF, 39, 11, 0xFFFFFF }, 90, 102, 186, 148, 197);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true;
    else
        return false;
    end
end

--step1
function lianxirenxiangqing_del_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
    	return self.action(self)
    else
        error_info("进入联系人详情 界面错误")
        return false
    end

end

--step2
function lianxirenxiangqing_del_page:check_page()  --检查是否是在当前页面--
    print("lianxirenxiangqing_del_page:check_page");
    print(self.page_name)
    local try_time = 1
    while 3 < try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_lianxirenxiangqing_del() then 
            return true;
        else          
            try_time = try_time + 1;
        end
    end
    return false;
end

function lianxirenxiangqing_del_page:quick_check_page()  --检查是否是在当前页面--
    return check_page_lianxirenxiangqing_del()
end

--step3  --最主要的工作都在这个里面
function lianxirenxiangqing_del_page:action()     --执行这个页面的操作--
    print("lianxirenxiangqing_del_page:check_page");
    print(self.page_name)

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
    page_array["page_suoyoulianxiren_del"]:enter();
    return true;
end

page_array["page_lianxirenxiangqing_del"] = lianxirenxiangqing_del_page:new()

--end page_lianxirenxiangqing_del.lua