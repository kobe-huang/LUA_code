--默认微信用户参数---
--缩写pb： phone_book

default_pb_app_user = {
    user_name = "default",  -- 用户名称
    user_snap_info = "xxxxxxxx",            --用户特征信息
    user_data = {
        phone_add_contact_num = 0;       --添加电话通讯录次数
        phone_add_contact_total_num = 0; -- 总次数
    }                 
}

--默认微信app数据--
phone_book_app_data = {
    app_name = "phone_book",
    app_info = {  
                app_snap_info = {},  --app特征值
                app_image_path = "",
                current_user_index = 1,         --当前是那个用户;
                user_list = {default_pb_app_user}, --用户列表
            } ,
    app_user_key_point = {
                 point_x = 320,  --用户标识的点
                 point_y = 180
                },          
    app_ctrl_func_list = {
                    "default_func", --默认
                    "pb_add_contact",       --电话簿中，微信检测新的朋友，加好友
                    "pb_del_contact",             --站街，打招呼
                },
    app_nv      = nil,
    app_nv_path = "",
    app_nv_name = "",
   -- app_snap_iamge = {} --截图数组，hash数组
} 

--新建
phone_book_app_class = class_base_app:new(phone_book_app_data);


function phone_book_app_class:enter_account_page( ... )
    print("phone_book_app_class:enter_account_page");
    -- body
end

----------------
function phone_book_app_class:init_user( ... )
end

----------------------
function phone_book_app_class:func_pb_add_contact( ... )
    -- body
    print("phone_book_app_class:func_wx_add_contact_by_phone_book_link");
end
function phone_book_app_class:func_pb_add_contact_finish()
    -- body
    self.app_info.user_list[self.app_info.current_user_index].user_name = "huangyinke";
    self:update_to_nv();
    print("phone_book_app_class:func_wx_add_contact_by_phone_book_link_finish");
end

-----------------------
function phone_book_app_class:func_pb_del_contact( ... )
    -- body
end
function phone_book_app_class:func_pb_del_contact_finish( ... )
    -- body
end

-------------------------------------------test 部分-------------------------
function test_pb_app( ... )
    -- body
    my_pb_app = phone_book_app_class:new();
    my_pb_app:init_user();
    my_pb_app:do_func("func_pb_add_contact");
    my_pb_app:finish_func("func_pb_add_contact");

end

-- function main( ... )
--     -- body
--     test_pb_app();
-- end