--用来将文件打包 package--
local  package_name = "sl_main.lua"
local package_file_list = {
  "sl_package_config.lua",
  "lib_file_log.lua",
  "class_base_page.lua", 
  "page_all_data.lua",                    
  "page_main.lua",             
  "page_suoyoulianxiren_del.lua",  
  "page_lianxirenxiangqing_del.lua",
  "page_suoyoulianxiren.lua",
  "page_xinlianxiren.lua",    
  "func_add_contact.lua" 
}

function file_save_load(filename, file)
	local myfile = io.open(filename, "r");
	assert(myfile);
	local data = myfile:read("*a"); -- 读取所有内容
	myfile:close();
	file:write(data);
end

function start_package()
	file = io.open(package_name,"w");  --覆盖文件
	file:write("------------------------" .. package_name .."--------\n");
	file:write("--                                             --\n");
	file:write("--                                             --\n");
	rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    rightnow_time = os.date("%H:%M:%S");
    time = "--" .. rightnow_data .. "  " .. rightnow_time .. "     kobe package \n"
	file:write(time)
	file:write("--                                             --\n");
	file:write("--                                             --\n");
	file:write("--                                             --\n");
	file:write("-------------------------------------------------\n\n\n\n");
	file:close();

	file = io.open(package_name,"a");
	for i,v in ipairs(package_file_list) do		
		file:write("\n\n\n\n" .. "----------------------begin:  " .. v .. "---------------------------------\n")
		file_save_load(v, file);
		file:write("\n" .. "------------------end:  " .. v .. "-------------------------------------\n")
		
	end
	file:close();
end

start_package()


--[[
function writeStrToFile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
end

function SaveTableContent(file, obj)
      local szType = type(obj);
      print(szType);
      if szType == "number" then
            file:write(obj);
      elseif szType == "string" then
            file:write(string.format("%q", obj));
      elseif szType == "table" then
            --把table的内容格式化写入文件
            file:write("{\n");
            for i, v in pairs(obj) do
                  file:write("[");
                  SaveTableContent(file, i);
                  file:write("]=\n");
                  SaveTableContent(file, v);
                  file:write(", \n");
             end
            file:write("}\n");
      else
     	 error("can't serialize a "..szType);
      end
end

function SaveTable(myfile, table_name, table)
      local file = io.open(myfile, "a");
      assert(file);
      file:write(table_name .. " = {\n");

      SaveTableContent(file, table);

      file:write("}\n");
      file:close();
end

SaveTable(package_name, "my_globle_para", my_globle_para)
]]--