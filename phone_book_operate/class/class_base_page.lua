--class_base_page.lua begin--
class_base_page = {
    page_name = "default_page", 
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/default_page.bmp",
    page_action_list = {},  --进入这个页面的处理
    page_error_code = 101   --错误码
   -- page_snap_iamge = {} --截图数组，hash数组
} 


function class_base_page:new(o) --新建页面--
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

function class_base_page:quick_check_page() --快速检查页面--
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
function class_base_page:get_page_name()  --得到这个页面的名字
    return self.page_name;
end
--

function class_base_page:error_handling()  --在这个页面的错误处理
    -- body
    if self.page_error_code == 101  then    --默认错误处理，
        mSleep(2000)
        error_info(self:get_page_name());
        mSleep(5000)
        tongzhi()
        local current_page = get_current_page(); --得到当前的page
        if false ~= current_page then 
            page_array[current_page]:enter(); --直接进当前页面的处理
        else
            rotateScreen(0);
            mSleep(637);
            keyDown('HOME');
            mSleep(141);
            keyUp('HOME');

            mSleep(159);
            keyDown('HOME');
            mSleep(64);
            keyUp('HOME');

            mSleep(1025);
            touchDown(3, 62, 534)
            mSleep(8);
            touchMove(3, 66, 494)
            mSleep(16);
            touchMove(3, 72, 418)
            mSleep(22);
            touchMove(3, 94, 322)
            mSleep(13);
            touchMove(3, 128, 196)
            mSleep(14);
            touchMove(3, 176, 56)
            mSleep(19);
            touchUp(3)

            mSleep(1167);
            touchDown(5, 302, 614)
            mSleep(9);
            touchMove(5, 302, 578)
            mSleep(20);
            touchMove(5, 304, 508)
            mSleep(19);
            touchMove(5, 306, 406)
            mSleep(16);
            touchMove(5, 312, 296)
            mSleep(14);
            touchMove(5, 326, 164)
            mSleep(15);
            touchMove(5, 346, 38)
            mSleep(15);
            touchUp(5)
            mSleep(1917);
            keyDown('HOME');
            mSleep(176);
            keyUp('HOME');
            mSleep(2000);
            error_info(self:get_page_name());
            return false
        end
    end
end
--function sl_init_page
--class_base_page.lua end--