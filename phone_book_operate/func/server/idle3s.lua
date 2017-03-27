local sl_idle_time = 3000
local lua_value = "--idle sleep： "
lua_value = lua_value .. tostring(sl_idle_time)
notifyMessage(lua_value);
mSleep(sl_idle_time);