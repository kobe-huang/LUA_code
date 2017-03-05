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
        --error_info("进入新联系人 界面错误")
        self:error_handle();
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