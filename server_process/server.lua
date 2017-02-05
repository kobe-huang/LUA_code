--默认的值
local default_server_addr = "http://120.76.215.162/sl_base/addons/xsy_resource/gettaskdemo.php?task="
local test_data ={  --json格式的数据
    ms_id = "ABCDEFG12345678"
    , ms_type = "ip4"
    ,ms_act = "kobe" 
    ,ms_pwd = "H11111111h"
    ,ms_token = "shunliantianxia12345"
    , ms_stg_id = 40004
    , ms_task_id = 50005
    , ms_task_d_id = 50003
    , ms_status = "ideal" };

class_base_server = {
    server_addr = default_server_addr,
} 

--新建一个服务器--
function class_base_server:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    self.JSON =  require "JSON"
    return o    --最后返回构造后的对象实例
end

--设置服务器接口地址
function class_base_server:set_server_addr(addr) 
    self.server_addr = addr;
    return true;
end

--得到服务器接口地址
function class_base_server:get_server_addr()
    return self.server_addr;
end


--发送GET消息；参数sl_data为table型的数据
function class_base_server:send_info(sl_data)
    if type(sl_data) ~= 'table' then
        return false;
    end
    local raw_json_text = (self.JSON):encode(sl_data)  
    local xxxx = self.server_addr .. raw_json_text;
    local mydata = httpGet(xxxx);
    mSleep(1000);

    local ret_value = (self.JSON):decode(mydata)
    if nil == ret_value then --如果不是json数据，会返回nil
        return false
    else
        return ret_value
    end
end

--下载文件
--后期也可以改成luasocket的模式
function class_base_server:get_file(local_path,sl_url) 
    os.execute("curl -o " .. local_path .." " .. sl_url)
    return true;
end