----临时变量---
sl_var_table = {};
function set_var_item( item_name, value )
    -- body
    sl_var_table[item_name] = value;
end
function get_var_item( item_name )
    -- body
    return sl_var_table[item_name];
end

--------
sl_track = {};
function init_track()
    sl_track = class_track:new(default_class_track);
    sl_track:init();
end

sl_nv = {};
function init_nv()
    sl_nv = class_nv:new(default_class_nv);
    sl_nv:init();
end

--------------埋点接口---------------------
function track_write_record_item(item, value)
    sl_track:write_record_item(item, value);
end

function track_read_record_item(item)
    return sl_track:read_record_item(item);
end

function track_clean_records()
    sl_track:clean_records();
end

--发送埋点信息--
function send_track_info()
	sl_ms:send_info(sl_track.records_table);
end

-------------复位设备--------------
function reset_ms_server()
	-- body
	reset_table = {
		ms_reset = "true"
	}
	sl_ms:send_info(reset_table);
end

------------nv 接口-------------
function nv_write_nv_item(item, value)
    sl_nv:write_nv_item(item, value);
end

function nv_read_nv_item(item)
   return sl_nv:read_nv_item(item);
end

function nv_clean_nvs()
    sl_nv:clean_nvs();
end