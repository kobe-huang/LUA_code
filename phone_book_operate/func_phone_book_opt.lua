--文件以"func_" 开头,说明是一个功能性的脚本
--此功能是： 电话簿联系人操作，根据输入的参数，来添加或删除联系人

function generate_contact_info() --产生随机号码
    local  x = math.random(99999);
    local  xx = pre_fix_phone_numb[math.random(#pre_fix_phone_numb)]
    x = (xx * 100000) + x

    local  y = tostring(x)
    y = string.sub(y, -3, -1)

    local my_name = pre_fix_name[math.random(#pre_fix_name)] .. y
    x = tostring(x)
    --print(x)
    --print(my_name)
    return my_name, x;
    -- body
end

function add_contact_init()
end

function run_add_contact()
end

function rmv_all_contact()
end

function auto_create_name(name)
end

function phone_book_opt() --添加或删除联系人主函数
    ---mSleep(10000);
	logFileInit(sl_log_file);
    local current_page = get_current_page(); --得到当前的page
    if false ~= current_page then 
       page_array[current_page]:enter(); --直接进当前页面的处理
    else
	   page_array["page_main"]:enter();
    end
end

--功能性脚本的入口程序，使用dofile调用
--在调试的时候，使用main函数封装，才能运行
--function main()
    -- body
    phone_book_opt();
--end


--for i=1,20 do
--  generate_contact_info();
--end

