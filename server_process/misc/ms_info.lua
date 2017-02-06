
--得到本机的uuid
function get_ms_uuid()
	local  my_uuid =  getDeviceID(); 
	return my_uuid
end

--得到本机的型号
function get_ms_type()
	local my_ms_type = "ip4"
	width, height = getScreenResolution();                  -- 将屏幕宽度和高度分别保存在变量w、h中
	--脚本判断使用的机器是否是iphone5
	if width == 640 and height == 1136 then
	    my_ms_type = "ip5"  
	end
	return my_ms_type;
end
