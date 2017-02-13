pre_fix_phone_numb   = {1865571}--1388888, 1355555, 1344444,1366666}--号段前缀
pre_fix_name = {"艾","毕","蔡","代","厄","方","甘","黄","马","赵","钱","孙","李","周","吴","郑","王"};
mask_numb = 5   --尾后5位数
add_numb  = 50   --每次加的数目
add_interval = 600;  --每次加号码后，休息的时间，单位秒
del_contact_num = 10 --多少次后，直接删除所有的电话簿

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

function main()
    mSleep(10000);
	logFileInit(sl_log_file);
	page_array["page_main"]:enter();
end

--for i=1,20 do
--  generate_contact_info();
--end

