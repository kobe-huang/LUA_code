--默认微信用户参数---
default_wx_app_user = {
    user_name = "default_wx_account",  -- 用户名称
    user_snap_info = "1212121212112121212",            --用户特征信息
    user_data = {
        wx_add_contact_req_num = 0,                    --发起添加微信联系人次数
        wx_add_contact_req_total_num= 0,               --    总次数
        wx_add_contact_success_num= 0,                 --  发起添加微信联系人成功次数
        wx_add_contact_success_total_num= 0,           --    总次数
        wx_add_contact_by_say_hello_num= 0,            -- 站街，打招呼的次数
        wx_add_contact_by_say_hello_total_num= 0,      --   总次数
        wx_add_contact_by_group_num= 0,                -- 通过= 0,  --信群加好友的次数
        wx_add_contact_by_group_total_num = 0,         --   总次数
        wx_add_contact_by_search_phone_num = 0,        -- 搜索电话加好友
        wx_add_contact_by_search_phone_total_num = 0,  --   总次数
        wx_add_contact_by_phone_book_link_num = 0,     --  电话簿中，微信检测新的朋友，加好友
        wx_add_contact_by_phone_book_link_total_num = 0,  --总次数
        wx_accept_req_num = 0,                         --  接受微信联系人，添加自己
        wx_accept_req_total_num = 0,                   --总次数
        wx_forward_friend_circle_num = 0,              --   转发朋友圈次数
        wx_forward_friend_circle_total_num = 0,        -- 总次数
        wx_reject_friend_num  = 0,                     --  被微信好友删除/拉黑次数
        wx_reject_friend_total_num = 0,                -- 总次数
        wx_add_contact_status = 0,                     --  微信的状态：在加粉的时候做判断
        wx_xxx_status = 0,                             --  微信的状态
    }                 
}
--默认微信app数据--
weixin_app_data = {
    app_name = "weixin",
    app_info = {  
                app_snap_info = {},  --app特征值
                app_image_path = "",
                current_user_index = 1,         --当前是那个用户;
                user_list = {default_wx_app_user}, --用户列表
            } ,
    app_user_key_point = {
                 point_x = 320,  --用户标识的点
                 point_y = 180
                },          
    app_ctrl_func_list = {
                    "default_func", --默认
                    "wx_add_contact_by_phone_book_link",       --电话簿中，微信检测新的朋友，加好友
                    "wx_add_contact_by_say_hello",             --站街，打招呼
                    "wx_add_contact_by_group",                 --通过微信群加好友
                    "wx_add_contact_by_search_phone",          --搜索电话加好友
                    "wx_accept_req",                           --接受微信联系人，添加自己
                    "wx_forward_friend_circle",                --转发朋友圈
                    "wx_reject_friend"                         --被微信好友删除/拉黑
                },
    app_nv      = nil,
    app_nv_path = "",
    app_nv_name = "",
   -- app_snap_iamge = {} --截图数组，hash数组
} 

--新建
weixin_app_class = class_base_app:new(weixin_app_data);

function weixin_app_class:enter_account_page( ... )
    print("weixin_app_class:enter_account_page");
    -- body
end

----------------
function weixin_app_class:func_default_func( ... )
end
function weixin_app_class:func_default_func_finish( ... )
end

----------------------
function weixin_app_class:func_wx_add_contact_by_phone_book_link( ... )
    -- body
    print("weixin_app_class:func_wx_add_contact_by_phone_book_link");
end
function weixin_app_class:func_wx_add_contact_by_phone_book_link_finish(in_para)
    -- body
    self.app_info.user_list[self.app_info.current_user_index].user_name = in_para;
    self:update_to_nv();
    print("weixin_app_class:func_wx_add_contact_by_phone_book_link_finish");
end

-----------------------
function weixin_app_class:func_wx_add_contact_by_say_hello( ... )
    -- body
end
function weixin_app_class:func_wx_add_contact_by_say_hello_finish( ... )
    -- body
end

-------------------------------------------test 部分-------------------------
function test_wx_app( ... )
    -- body
    my_wx_app = weixin_app_class:new();
    my_wx_app:init_user();
    my_wx_app:do_func("wx_add_contact_by_phone_book_link");
    my_wx_app:finish_func("wx_add_contact_by_phone_book_link",  "huangyinke---");

end

-- function main( ... )
--     -- body
--     test_wx_app();
-- end