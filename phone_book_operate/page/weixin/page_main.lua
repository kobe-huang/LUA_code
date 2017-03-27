--begin page_main.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"
default_main_page = {
	page_name = "main_page",
	page_image_path = nil
}

main_page = class_base_page:new(default_main_page);

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
local function action_phone_book_opt() --执行这个页面的操作--
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
    	--error_info("进入主界面错误")
        self:error_handle();
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
    return action_phone_book_opt();
end

page_array["page_main"] = main_page:new()
--end page_main.lua