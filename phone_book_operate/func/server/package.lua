--用来将文件打包 package--

 func_name = "server" --功能的名称 
 __FILE__ = debug.getinfo(1,'S').source:sub(2)

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

local function get_current_dir( ... )
	-- body
	 myfile = __FILE__;
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

local function get_prj_root_dir()  --往上2级目录
	local root_dir = __FILE__;
	for i=1,2 do
		root_dir = get_dir_name(root_dir);
		--print(root_dir);
		root_dir = string.sub(root_dir, 1, -2)
		--print(root_dir);
		root_dir = root_dir .. ".del"
	end
	root_dir = get_dir_name(root_dir);
	return root_dir;
end

--print(get_current_dir());
--print(get_prj_root_dir());

root_dir = get_prj_root_dir();
current_dir   = get_current_dir();

package_file_list = {
  "lib\\lib_JSON.lua",
  "lib\\lib_file_operate.lua",
  "misc\\ms_info.lua",
  "class\\class_server.lua", 
  "class\\class_ms.lua",
  "func\\server\\server.lua"               
}


dofile(root_dir .. "package\\sl_package.lua")
start_package(func_name, root_dir, package_file_list); 