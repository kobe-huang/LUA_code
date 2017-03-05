--用来将文件打包 package--

 func_name = "dianhuaben_operate" --功能的名称 
 __FILE__ = debug.getinfo(1,'S').source:sub(2)


package_file_list = {
  "lib/lib_file_operate.lua",
  "class/class_base_page.lua", 
  "page/page_all_data.lua",    --放在page的第一位                 
  "page/dianhuaben/page_main.lua",             
  "page/dianhuaben/page_suoyoulianxiren.lua",  
  "page/dianhuaben/page_lianxirenxiangqing.lua",
  "page/dianhuaben/page_xinlianxiren.lua",
  "func/dianhuaben/dianhuaben_operate.lua"         
}

dofile("../../lib/lib_file_operate.lua")

root_dir  = get_prj_root_dir(__FILE__, 2);
--current_dir   = get_current_dir(__FILE__);

dofile(root_dir .. "package/sl_package.lua")

start_package(func_name, root_dir, package_file_list); 