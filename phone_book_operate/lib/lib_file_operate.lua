--begin lib_file_log.lua
require "string"
--------------------------------文件地址操作-------
--得到文件的全部路径
function get_FILE_path( ... )
    local __FILE__ = debug.getinfo(1,'S').source:sub(2)
    return __FILE__;
    -- body
end

--得到文件的路径
function get_dir_name(str)  
    if str:match(".-/.-") then  
        local name = string.gsub(str, "(.*/)(.+)", "%1")  
        return name  
    elseif str:match(".-\\.-") then  
        local name = string.gsub(str, "(.*\\)(.+)", "%1")  
        return name  
    else  
        return nil
    end  
end  

--获取路径，去除文件名  
function strip_file_name(filename)  --
    if filename:match(".-/.-") then 
        return string.match(filename, "(.+)/[^/]*%.%w+$")   --*nix system 
    elseif filename:match(".-\\.-") then   
        return string.match(filename, "(.+)\\[^\\]*%.%w+$") -- windows
    else  
        return nil
    end   
end    


--获取文件名  ，去除文件路径  
function strip_path(filename)
    if filename:match(".-/.-") then 
        return string.match(filename, ".+/([^/]*%.%w+)$")   -- *nix system  
    elseif filename:match(".-\\.-") then   
        return string.match(filename, ".+\\([^\\]*%.%w+)$") -- *nix system
    else  
        return nil
    end    
end  

--去除扩展名 
function strip_extension(filename)  
    local idx = filename:match(".+()%.%w+$")  
    if(idx) then  
        return filename:sub(1, idx-1)  
    else  
        return filename  
    end  
end  
  
--获取扩展名  
function get_extension(filename)  
    return filename:match(".+%.(%w+)$")  
end  

--得到当前目录
function get_current_dir(myfile)
    -- body
     --myfile = __FILE__;
     if myfile:match(".-/.-") then  
        local name = string.gsub(myfile, "(.*/)(.+)", "%1")  
        return name  
    elseif myfile:match(".-\\.-") then  
        local name = string.gsub(myfile, "(.*\\)(.+)", "%1")  
        return name  
    else  
        return nil
    end  
end

--得到根目录
function get_prj_root_dir(root_dir, num)  --当前目录，往上num级目录
    --local root_dir = __FILE__;
    for i=1,num do
        root_dir = get_dir_name(root_dir);
        --print(root_dir);
        root_dir = string.sub(root_dir, 1, -2)
        --print(root_dir);
        root_dir = root_dir .. ".del"
    end
    root_dir = get_dir_name(root_dir);
    return root_dir;
end

-----------------------------------------------------------

 
--判断文件是否存在
function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end


--将二进制的文件转换成--
function fileToHexString(file)  
        local file = io.open(file, 'rb');
        local data = file:read("*all");
        log_info( type(data) )
        file:close();
        local t = {};
        for i = 1, string.len(data),1 do
                local code = tonumber(string.byte(data, i, i));
                table.insert(t, string.format("%02x", code));
        end
        return table.concat(t, "");
end


--在文件（文本文件）中，找特定的字串--
function isStringInFile(mystring, file) 
    local BUFSIZE = 8192
    local f = io.open(file, 'r')  --打开输入文件
    
    while true do
        local lines,rest = f:read(BUFSIZE,"*line")
        if not lines then
            break
        end
        if rest then
            lines = lines .. rest .. "\n"
        end
        
        local i = string.find(lines,mystring);
        if nil ~= i then
            f:close();
            return true;
        end
    end
     f:close();
    return false;
 end   

--清除文件内容--
function clean_file(file)
    local f = io.open(file, 'w+');
    f:close();
end

--写字串到到文件中--
function writeStrToFile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
end

----------------------------------------------------------------截图操作-------------------------------------
----保存截图到文件中---
function save_card_info(file_name, x, y, xx, yy, mystring,file_name1) --保存联系人信息--
    snapshotRegion(file_name, x, y, xx, yy); -- 将区域[(100,100)(200,200)]的截图保存到路径为/mnt/sdcard/a.bmp的图片中, 格式为BMP
    writeStrToFile(mystring,file_name1)
end

--得到屏幕中的关键信息--
function get_pic_key_info(x, y) --得到屏幕中的关键信息--
    local file_name = "/private/var/touchelf/scripts/sl/temp_XXXX.bmp"
    snapshotRegion(file_name, x, y, x+80, y); 
    return fileToHexString(file_name);
end

---检查是否有重复的信息---
function check_card_is_repeated(contact_index_file, x, y)  --检查是否是重复的联系人  文件和查找的点---
    local card_info = get_pic_key_info(x, y);
    if true ==  isStringInFile(card_info, contact_index_file) then
        return true;
    else
        return card_info;
    end    
end
--

--------------------------------------------------------------log----------------------------------------
--初始化log文件
function logFileInit(log_file_name)   
    rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    rightnow_time = os.date("%H:%M:%S");
    local file_path = strip_file_name(log_file_name)
    if false == file_exists(file_path) then  --创建自己的临时文件夹
          os.execute("mkdir -p " .. file_path);
    end
    --writeStrToFile(rightnow_data .. " " .. rightnow_time .. "   ++++begin+++", log_file_name); 
    sl_log_file = log_file_name;
end

if sl_log_file == nil then  --设置默认log文件
    sl_log_file = "/private/var/touchelf/scripts/sl/sl_log.txt";
end

--得到本机当前时间
function get_local_time()
    local rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    local rightnow_time = os.date("%H:%M:%S");
    local my_time = rightnow_data .. ": " .. rightnow_time .. ": "
    return my_time;
end 

--输出信息到文件
function log_info(out_info)  ---错误处理函数   
    --notifyMessage(out_info);
    local time = get_local_time(); 
    writeStrToFile("info:  " .. time .. out_info , sl_log_file);    
end

function error_info_exit(out_info)  ---错误处理函数   
    local time = get_local_time(); 
    writeStrToFile("fatal error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("致命错误：".. out_info);   
    mSleep(3000);
    --page_array["page_main"]:enter();  --重新开始
    os.execute("reboot");
    --os.exit(1);
end

error_time = 1;
function error_info(out_info)  ---错误处理函数   
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("错误：" .. out_info);
    mSleep(1200);
    if nil ~= sl_error_time then
        error_time = error_time + 1;
        if error_time >= sl_error_time then
            error_info_exit("错误次数太多");
        else
           -- page_array["page_main"]:enter();  --重新开始
        end
    else
        os.exit(1);
    end
    --os.exit(1);
end

--输出警告信息到文件
function warning_info(out_info)  ---错误处理函数   
    notifyMessage("警告：" .. out_info);
    mSleep(1200);
    local time = get_local_time(); 
    writeStrToFile("warning:  " .. time .. out_info , sl_log_file);    
end

--end lib_file_log.lua