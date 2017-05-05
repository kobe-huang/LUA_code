--class_app_base.lua begin--


--简要逻辑：
-- 设备从服务器上领取任务；
-- 设备将任务提交给app模块；
-- app模块计算出任务的参数2，返回给设备；
-- 设备执行完任务，将执行结果返回给app，app记录；

--this class is for app
--APP中用户信息
local_app_info_path         = "/private/var/touchelf/scripts/sl/" --配置文件,
local_app_info_prefix_name  = "_app_nv.txt"
app_nv_prefix_name          = "_app_nv"


default_app_user = {
    user_name       = "default_account",  -- 用户名称
    user_snap_info  = "12212121212121",   --用户特征信息
    user_data       = {},                 --用户在这个设备上的信息
};

--base APP信息
class_base_app = {
    app_name = "default_app",
    app_info = {  
                app_snap_info = {},  --app特征值
                app_image_path = "",

                current_user_index = 1,         --当前是那个用户;
                user_list = {default_app_user}, --用户列表
            }, 
    app_user_key_point = { point_x = 80, point_y = 80},           --用户标识的点
    app_ctrl_func_list = {"default_func"},   --control func list 功能列表
    app_nv = nil,
    app_nv_path = "",
    app_nv_name = "",
   -- app_snap_iamge = {} --截图数组，hash数组
} 

--新建app对象--
function class_base_app:new(o) 
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self 

    --设置路径
    self.app_nv_path = local_app_info_path .. self.app_name .. local_app_info_prefix_name;
    self.app_nv_name = self.app_name .. app_nv_prefix_name;
    self.app_nv = class_nv:new(); --初始化
    self.app_nv.local_nv_path = self.app_nv_path;
    self.app_nv:init();
   
    local tmp_nv = self.app_nv:read_nv_item(self.app_nv_name); --初始化nv项目
    if nil ~= tmp_nv and type(tmp_nv) == 'table' then
        self.app_info = tmp_nv;
    end
    return o    --最后返回构造后的对象实例
end

--得到APP名称--
function class_base_app:get_app_name()      
    return self.app_name;
end



--用户相关--

--进入用户帐号界面--
function class_base_app:enter_account_page()
    -- body
end

--初始化用户--
function class_base_app:init_user()  
    --在用户中心界面，去读取用户名的特征值 
    self:enter_account_page();     
    local user_key_info = get_pic_key_info(self.app_user_key_point.point_x, self.app_user_key_point.point_y);
    local is_find_user = false;
    local my_index = 1;
    if nil ~= self.app_info and type(self.app_info.user_list) == 'table' then
        for k,v in pairs(self.app_info.user_list) do
            if user_key_info == v.user_snap_info then
                self.app_info.current_user_index = k;
                is_find_user = true;
            end
            my_index = k;
        end

        if(false == is_find_user) then
            self.app_info.current_user_index = (my_index + 1);
            self.app_info.user_list[self.app_info.current_user_index] = {};
            self.app_info.user_list[self.app_info.current_user_index].user_snap_info = user_key_info;
            self:update_to_nv(); --写入nv文件中
        end
    else
        self.app_info = {};
        self.app_info.current_user_index = 1;
        self.app_info.user_list = {};
        self.app_info.user_list[self.app_info.current_user_index] = {};
        self.app_info.user_list[self.app_info.current_user_index].user_snap_info = user_key_info;
        self:update_to_nv(); --写入nv文件中
    end

    --print("class_base_app:check_app");
    --print(self.app_name)
    return true;
end

--更新用户信息到nv--
function class_base_app:update_to_nv()  
    self.app_nv:write_nv_item(self.app_nv_name, self.app_info);
    --print("class_base_app:check_app");
    --print(self.app_name)
    return true;
end

--step1 执行某个操作之前调用
function class_base_app:do_func(func_name, in_para)  
    if type(func_name) ~= 'string' then
        return false;
    end

    for k,v in ipairs(self.app_ctrl_func_list) do
      if v == func_name then
         local func_name = 'func_' .. func_name;
         return self[func_name](self,in_para);
      end
    end
    return false; 
    --print(self.app_name);
end

--step2 当执行完某个操作完成之后调用
function class_base_app:finish_func(func_name, in_para) 
    if type(func_name) ~= 'string' then
        return false;
    end

    for k,v in ipairs(self.app_ctrl_func_list) do
      if v == func_name then
         local func_name = 'func_' .. func_name .. '_finish';
         local tmp_return = self[func_name](self,in_para);
         self:update_to_nv();
         return tmp_return;
      end
    end
    return false; 
    --print(self.app_name);
end

--错误处理
function class_base_app:error_handle()  
    -- body
    if self.app_error_code == 101 then    --默认错误处理，按返回键
        keyDown('HOME');    --HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      --HOME键抬起
        mSleep(3000);
        warning_info(self:get_app_name());
    end
end


--应用处理
function class_base_app:func_default_func() 
    print("func_default_func");
end
function class_base_app:func_default_func_finish() 
    print("func_default_func_finish");
end


-------------------------------------------------test case----------------------------------------
function test_class_app_base( ... )
    -- body
    my_app = class_base_app:new();
    my_app:init_user();

    my_app.app_info.current_user_index = 10;
    my_app:update_to_nv();

    my_app:do_func("default_func");
    my_app:finish_func("default_func");

end

-- function main( ... )
--     -- body
--     test_class_app_base();
-- end

--class_app_base.lua end--