--埋点，用来跟踪用户数据
--从服务器得到的数据(格式)--

--API：

--默认的参数
default_class_track= {
--    server_addr = default_server_addr,
    local_track_path  = "/private/var/touchelf/scripts/sl/sl_track.txt", --配置文件,
    records_table = {
        ms_track = "true",
     }           --数据的名称
};


class_track = {};
--新建一个服务器--
function class_track:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    --self.JSON =  require "JSON"
    self.JSON = OBJDEF:new();
    return o    --最后返回构造后的对象实例
end

function class_track:init()    
    local file_path = strip_file_name(self.local_track_path);
    if false == file_exists(file_path) then  --创建自己的临时文件夹
          os.execute("mkdir -p " .. file_path);
    end
    if false == file_exists(self.local_track_path) then
        self.records_table = { 
            ms_track = "true"
        };
        wirtjson =(self.JSON):encode(self.records_table)--转换成json格式
        local test = assert(io.open(self.local_track_path, "w"))
        test:write(wirtjson)
        test:close()
    else
        local test      = io.open(self.local_track_path, "r");
        local readjson  = test:read("*a");
        self.records_table = (self.JSON):decode(readjson);
    end
end

--设置服务器接口地址
function class_track:write_record_item(item, value) 
    self.records_table[item] = value;
    wirtjson =(self.JSON):encode(self.records_table)--转换成json格式
    
    local test = assert(io.open(self.local_track_path, "w"))
    test:write(wirtjson)
    test:close()
    return true;
end

--得到服务器接口地址
function class_track:read_record_item(item)
    return self.records_table[item];
end


--发送GET消息；参数sl_data为table型的数据
function class_track:clean_records()
   self.records_table = { 
            ms_track = "true"
    };
   wirtjson =(self.JSON):encode(self.records_table)--转换成json格式
   local test = assert(self.local_track_path, "w");
   test:write(wirtjson)
   test:close()
end


-- -----that's for test---
-- sl_track = {};

-- function init_track()
--     sl_track = class_track:new(default_class_track);
--     sl_track:init();
-- end

-- -----给其他程序的接口----
-- function track_write_record_item(item, value)
--     sl_track:write_record_item(item, value);
-- end

-- function track_read_record_item(item)
--    return sl_track:read_record_item(item);
-- end

-- function track_clean_records()
--     sl_track:clean_records();
-- end

-- function send_track_info()
--     sl_ms:send_info(sl_track.records_table);
-- end

-- function test_track( ... )
--     init_track();
--     track_write_record_item('huang', 'yinle');
--     local aaa = track_read_record_item('huang');
--     notifyMessage('aaa = ' .. aaa);
--     -- body
-- end