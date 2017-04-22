--埋点，用来跟踪用户数据
--从服务器得到的数据(格式)--

--API：
default_server_addr =  "http://120.77.34.177/sl_base/addons/xsy_resource/gettask.memcache.php?task="

--默认的参数
default_class_nv= {
--    server_addr = default_server_addr,
    local_nv_path  = "/private/var/touchelf/scripts/sl/sl_nv.txt", --配置文件,
    nvs_table = {
        ms_nv = "true",
     }           --数据的名称
};


class_nv = {};
--新建一个服务器--
function class_nv:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    --self.JSON =  require "JSON"
    self.JSON = OBJDEF:new();
    return o    --最后返回构造后的对象实例
end

function class_nv:init()    
    local file_path = strip_file_name(self.local_nv_path);
    if false == file_exists(file_path) then  --创建自己的临时文件夹
          os.execute("mkdir -p " .. file_path);
    end
    if false == file_exists(self.local_nv_path) then
        self.nvs_table = { 
            ms_nv = "true"
        };
    else
        local test      = io.open(self.local_nv_path, "r");
        local readjson  = test:read("*a");
        self.nvs_table = (self.JSON):decode(readjson);
    end
end

--设置服务器接口地址
function class_nv:write_nv_item(item, value) 
    self.nvs_table[item] = value;
    wirtjson =(self.JSON):encode(self.nvs_table)--转换成json格式
    
    local test = assert(io.open(self.local_nv_path, "w"))
    test:write(wirtjson)
    test:close()
    return true;
end

--得到服务器接口地址
function class_nv:read_nv_item(item)
    return self.nvs_table[item];
end


--发送GET消息；参数sl_data为table型的数据
function class_nv:clean_nvs()
   self.nvs_table = { 
            ms_nv = "true"
    };
   wirtjson =(self.JSON):encode(self.nvs_table)--转换成json格式
   local test = assert(self.local_nv_path, "w");
   test:write(wirtjson)
   test:close()
end


-- -----that's for test---
-- sl_nv = {};

-- function init_nv()
--     sl_nv = class_nv:new(default_class_nv);
--     sl_nv:init();
-- end

-- -----给其他程序的接口----
-- function nv_write_nv_item(item, value)
--     sl_nv:write_nv_item(item, value);
-- end

-- function nv_read_nv_item(item)
--    return sl_nv:read_nv_item(item);
-- end

-- function nv_clean_nvs()
--     sl_nv:clean_nvs();
-- end

-- function send_nv_info()
--     sl_ms:send_info(sl_nv.nvs_table);
-- end

-- function test_nv( ... )
--     init_nv();
--     nv_write_nv_item('huang', 'yinle');
--     local aaa = nv_read_nv_item('huang');
--     notifyMessage('aaa = ' .. aaa);
--     -- body
-- end