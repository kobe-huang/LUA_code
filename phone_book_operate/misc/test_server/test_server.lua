require "socket.ftp"
if handling_time == nil then
	handling_time = 3000;
end

if task_name == nil then
	task_name = "空字符串"
end

log_file = "/private/var/touchelf/scripts/sl/sl_server_log.txt";
notifyMessage(task_name .. "sleep: " .. tostring(handling_time) )

logFileInit(log_file);
log_info( task_name .. " : " .. tostring(handling_time))

mSleep(handling_time)
