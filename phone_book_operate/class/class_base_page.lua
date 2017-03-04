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
    if self.page_error_code == 101 then    --默认错误处理，按返回键
        keyDown('HOME');    --HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      --HOME键抬起
        mSleep(3000);
        warning_info(self:get_page_name());
    end
end

--function sl_init_page
--class_base_page.lua end--