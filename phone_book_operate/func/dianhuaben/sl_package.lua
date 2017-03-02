--用来将文件打包 package--
require "string"
local  func_name = "phone_book_opt" --功能的名称
local  package_name = "sl_func_" .. func_name ..".lua"
--local  package_name_conf = "sl_func_conf.lua"

local package_server_file_list = {
  "sl_package_config.lua",
  "./lib/lib_JSON.lua",
  "./misc/ms_info.lua",
  "./misc/file_log.lua",
  "./class/class_server.lua", 
  "./class/class_ms.lua",
  "main.lua"               
}


local package_file_list = {
  --"sl_package_config.lua",
  "./lib/lib_file_log.lua",
  "./class/class_base_page.lua", 
  "./page/page_all_data.lua",    --放在page的第一位                 
  "./page/page_main.lua",             
  "./page/page_suoyoulianxiren.lua",  
  "./page/page_lianxirenxiangqing.lua",
  "./page/page_xinlianxiren.lua",
  "func_phone_book_opt.lua"
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
  file:write("------------" .. package_name .."------------\n"); --12个横杠
  local file_len = string.len(package_name) + 20;
  local my_blank = string.rep(" ", file_len);
  local my_ganggang = string.rep("-", file_len); 

  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_blank .. "--\n");
  rightnow_data = os.date("%y%m%d");   --得到当前日期和时间
  rightnow_time = os.date("%h:%m:%s");
  time = "--" .. rightnow_data .. "  " .. rightnow_time .. "     kobe package \n"
  file:write(time)
  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_ganggang .. "--\n");
  file:write("\n\n\n\n");
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
function writestrtofile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
end

function savetablecontent(file, obj)
      local sztype = type(obj);
      print(sztype);
      if sztype == "number" then
            file:write(obj);
      elseif sztype == "string" then
            file:write(string.format("%q", obj));
      elseif sztype == "table" then
            --把table的内容格式化写入文件
            file:write("{\n");
            for i, v in pairs(obj) do
                  file:write("[");
                  savetablecontent(file, i);
                  file:write("]=\n");
                  savetablecontent(file, v);
                  file:write(", \n");
             end
      file:write("}\n");
      file:close();
      assert(file);

      file:write(table_name .. " = {\n");
            file:write("}\n");
      else
       error("can't serialize a "..sztype);
      end
end

      savetablecontent(file, table);

function savetable(myfile, table_name, table)
      local file = io.open(myfile, "a");
end

savetable(package_name, "my_globle_para", my_globle_para)
]]--