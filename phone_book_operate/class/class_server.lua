--begin class_server.lia---------------------
--服务器返回的数据：
--{Code = 101, Message = "OK", 
--data = {Strategy_ID = 40003, TaskDataID = 50003, 
--TaskDataPath = "http://oss.temaiol.com/file/1/20170116/ffafadf22197d046a0db00bcd60db6a0.lua", 
--TaskId = 50005, TaskPath = "http://oss.temaiol.com/file/1/20170116/ffafadf22197d046a0db00bcd60db6a0.lua"}}

--从服务器得到的数据(格式)--
base_return_info = {
    Code = 101,
    data = {
          message = "成功"
        , task_id = 50001
        , task_path = "http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg"
        , task_data_id = 50003
        , task_data_path = "http://oss.techouol.com/images/2/2016/12/YHLhGDDh0IGtSc30IE7i7TLC931T1d.jpg"
        , strategy_id = 40003
    }
}
--默认的参数
class_base_server = {
    server_addr = default_server_addr,
} 


default_ms_base_info = {    --json格式的数据
    ms_id = "ABCDEFG12345678"
    ,ms_type = "ip4"   -- ip4,ip4s,ip5,ip5c,ip5s,ip6.ip6s
    ,ms_act = "kobe"
    ,ms_pwd = "H11111111h"
    ,ms_token = "shunliantianxia12345"
};

--新建一个服务器--
function class_base_server:new(o)
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    --self.JSON =  require "JSON"
    self.JSON = OBJDEF:new();
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
    local mydata = httpGet(xxxx); --检查mydata的有效性
    --mSleep(1000);
    if nil == mydata then         --判断返回的数据是否正常
        return false
    else
        local ret_value = (self.JSON):decode(mydata)
        if 'table' ~= type(ret_value) then --如果不是json&table数据，会返回nil
            return false;
        else
            return ret_value;
        end
    end
end

--下载文件
--后期也可以改成luasocket的模式
function class_base_server:get_file(local_path,sl_url) 
    local try_time = 1
    while 5 >= try_time do
        os.execute("curl -o " .. local_path .." " .. sl_url)
        mSleep(1000*try_time);  --时间逐步加长
        if true == file_exists(local_path) then --只看是否下载下来
            if false == isStringInFile("<Error>", local_path) then 
                return true;
            else
                try_time = try_time + 1;
            end
        else
            try_time = try_time + 1;
        end
    end
    return false; 
end