pre_fix_phone_numb   = {1865571}--1388888, 1355555, 1344444,1366666}--号段前缀
pre_fix_name = {"赵","钱","孙","李","周","吴","郑","王"};
mask_numb = 5   --尾后5位数
add_numb  = 50   --每次加的数目
add_interval = 600;  --每次加号码后，休息的时间，单位秒
del_contact_num = 10 --多少次后，直接删除所有的电话簿

--得到本机当前时间
function get_local_time()
	local rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    local rightnow_time = os.date("%H:%M:%S");
    local my_time = rightnow_data .. ": " .. rightnow_time .. ": "
    return my_time;
end 

function error_info_exit(out_info)  ---错误处理函数   
	local time = get_local_time(); 
    writeStrToFile("fatal error:  " .. time .. out_info , sl_log_file); 
    notifyMessage(out_info);   
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(5000);
    --page_array["page_main"]:enter();  --重新开始
	os.exit(1);
end

sl_error_time = 1;
function error_info(out_info)  ---错误处理函数   
	local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage(out_info);   
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(5000);
    sl_error_time = sl_error_time + 1;
    if sl_error_time >= 30 then
    	error_info_exit("致命错误，退出---");
    else
    	page_array["page_main"]:enter();  --重新开始
    end
	--os.exit(1);
end



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

--for i=1,20 do
--	generate_contact_info();
--end

function add_contact_init()
end

function run_add_contact()
end

function rmv_all_contact()
end

function auto_create_name(name)
end

function main()
	logFileInit(sl_log_file);
	page_array["page_main"]:enter();
end


--print("it's kobe" .. package.path);
--[[
print(#pre_fix_phone_numb)
print(pre_fix_phone_numb[0])
for i=1,10 do
	print(math.random(99999))
end
print(math.random(3))
]]--

--copyText("你好")     -- 复制字符串“你好”到系统剪贴板
--text = clipText()   -- 将之前复制或剪贴的文字读取到变量text中
--inputText(text)     --在输入框中输入获取到的字符串

--输出错误信息到文件