--class_base_page.lua begin--
class_base_page = {
    page_name = "default_page", 
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/default_page.bmp",
    page_action_list = {},  --进入这个页面的处理
    page_error_code = 101   --错误码
   -- page_snap_iamge = {} --截图数组，hash数组
} 

function class_base_page:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    return o    --最后返回构造后的对象实例
end

mu_page = class_base_page:new();
print(mu_page.page_name)
mu_page.page_name = "huangyinke"
print(mu_page.page_name)
print(class_base_page.page_name)