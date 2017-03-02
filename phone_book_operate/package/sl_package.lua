--用来将文件打包 package--
require "string"

--通过文件名得到 打包后的 脚本
function get_package_name()
  local file_full_name = get_FILE_path();
  local func_full_name = strip_path(file_full_name);
  local func_name = strip_extension(func_full_name);
  local my_package_name = "sl_func_" .. func_name ..".lua";
  return my_package_name; 
end

--文件copy动作
function file_save_load(filename, file)
  local myfile = io.open(filename, "r");
  assert(myfile);
  local data = myfile:read("*a"); -- 读取所有内容
  myfile:close();
  file:write(data);
end


function start_package(func_name, root_dir, package_file_list) 
  local  package_name = "sl_func_" .. func_name ..".lua"
  file = io.open(package_name,"w");  --覆盖文件
  file:write("------------" .. package_name .."------------\n"); --12个横杠
  local file_len = string.len(package_name) + 20;
  local my_blank = string.rep(" ", file_len);
  local my_ganggang = string.rep("-", file_len); 

  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_blank .. "--\n");
  rightnow_data = os.date("%y%m%d");   --得到当前日期和时间
  --rightnow_time = os.date("%h:%m:%s");
  rightnow_time = os.date("%H:%M:%S");
  time = "--" .. rightnow_data .. "  " .. rightnow_time .. "     kobe package \n"
  file:write(time)
  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_blank .. "--\n");
  file:write("--" .. my_ganggang .. "--\n");
  file:write("\n\n\n\n");
  file:close();

  file = io.open(package_name,"a");

  ---全局的参数
  file:write("\n\n\n\n" .. "----------------------begin: sl_package_config.lua---------------------------------\n")
  local sl_config = root_dir .. "package\\sl_package_config.lua"
  file_save_load(sl_config, file);
  file:write("\n" .. "------------------end: sl_package_config.lua-------------------------------------\n")

  for i,v in ipairs(package_file_list) do   
    file:write("\n\n\n\n" .. "----------------------begin:  " .. v .. "---------------------------------\n")
    my_v = root_dir .. v;
    print("打包： " .. my_v);
    file_save_load(my_v, file);
    file:write("\n" .. "------------------end:  " .. v .. "-------------------------------------\n")    
  end
  file:close();
end

