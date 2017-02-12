----begin page_all_data.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
page_array = {} --所有的page table
function init_page(b)  
    if b.page_name then --这里将table对象b的name字段值作为personInfo的key信息。
    	if true == sl_globle_para.is_package then 
    		--donothing
            --page_array[b.page_name] = b.page_name:new() --放在各个page里面
    	else
	        require(b.page_name) --初始化页面对象
	        print("test");
	    end
    end
end

init_page{
    page_name = "page_main", --聊天主界面-群聊天
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};

init_page{
    page_name = "page_suoyoulianxiren",    --所有联系人界面--添加新联系人
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};
init_page{
    page_name = "page_xinlianxiren", --聊天主界面-群聊天
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};

init_page{
    page_name = "page_suoyoulianxiren_del", --所有联系人界面 --删除联系人
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};

init_page{
    page_name = "page_lianxirenxiangqing_del", --联系人详情界面 --删除联系人
 --   page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp"
};

----begin page_all_data.lua