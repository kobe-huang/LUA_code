sl_log_file       = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
--sl_error_time     = 1;  --容错处理,  现在不做容错处理。

task_list = {
	"dazhaohu",  -- 1. 打招呼
	"piaoliuping", --2. 捡瓶子
	"jiahaoyou",  --3. 加联系人
	"zhanjie"     --4. 站街
}

current_task_id = 1;

