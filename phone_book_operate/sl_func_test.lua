----测试脚本
local run_time = 10000; --功能运行次数

function main()
	for i=1,run_time do
		dofile("/var/touchelf/scripts/sl_package_config.lua");
		dofile("/var/touchelf/scripts/sl_func_phone_book_opt.lua");
		--dofile("/var/touchelf/scripts/add_自动新增手机联系人.lua");
		--输出log，记录运行次数，和状态
	end
end