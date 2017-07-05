function main()
	-- body
	os.execute("rm -rf /private/var/touchelf/scripts/sl"); --1. 清除手机中的脚本，及一切缓存数据;
	os.execute("rm -rf /private/var/touchelf/scripts/sl_main*");
	notifyMessage("复位成功！");
	mSleep("3000");
end