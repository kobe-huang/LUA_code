init_point{ name = "default", x = 1, y = 1 };   --默认
init_point{ name = "fanhui", x = 80, y = 80 };  --返回
init_point{ name = "weixin_anjian", x = 75,  y = 1075 };   --微信_按键(左下角)
init_point{ name = "liaotian_front", x = 360, y = 160 };   --聊天界面  --160, 1020
init_point{ name = "liaotian_end", x = 360, y = 1020 };   --聊天界面  --160, 1020

init_point{ name = "tianjia_dao_tongxunlu", x = 310, y = 785 };  --点击 添加到通讯录
init_point{ name = "dazhaohu", x = 320, y = 930 };  --点击 添加到通讯录
init_point{ name = "guanjiandian", x = 60, y = 250 };  --点击 添加到通讯录
--------------------------------------------------------------------------------------------------------------------------------------------------

init_part_screenshot{
    shot_name = "XXX", 
    shot_path = "/private/var/touchelf/scripts/contact/screen_shot/XXX.bmp", 
    shot_area = {shot_start_point_X=0, shot_start_point_Y=0, shot_end_point_X = 1, shot_end_point_Y = 1} 
};

init_part_screenshot{ --文字_微信--左上角返回
    shot_name = "wenzi_weixin", 
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/wenzi_weixin.bmp", 
    shot_area = {shot_start_point_X=10, shot_start_point_Y=40, shot_end_point_X = 160, shot_end_point_Y = 120} 
};
init_part_screenshot{ --文字_微信---中间位置
    shot_name = "wenzi_weixin1", 
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/wenzi_weixin1.bmp", 
    shot_area = {shot_start_point_X=230, shot_start_point_Y=50, shot_end_point_X = 390, shot_end_point_Y = 110} 
};


init_part_screenshot{ --文字_详细资料
    shot_name = "wenzi_xiangxiziliao", 
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/wenzi_xiangxiziliao.bmp", 
    shot_area = {shot_start_point_X=210, shot_start_point_Y=50, shot_end_point_X = 430, shot_end_point_Y = 110} 
};
init_part_screenshot{ --文字_添加到通讯录 ---会变化
    shot_name = "wenzi_tianjia_tongxunlu", 
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/wenzi_tianjia_tongxunlu.bmp", 
    shot_area = {shot_start_point_X=160, shot_start_point_Y=420, shot_end_point_X = 460, shot_end_point_Y = 880} 
};
init_part_screenshot{ --文字_去打个招呼  ---会变化
    shot_name = "wenzi_dazhaohu", 
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/wenzi_dazhaohu.bmp", 
    shot_area = {shot_start_point_X=220, shot_start_point_Y=500, shot_end_point_X = 430, shot_end_point_Y = 960} 
};

init_part_screenshot{--图片_群名称
    shot_name = "tupian_qunmingcheng", 
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/tupian_qunmingcheng.bmp", 
    shot_area = {shot_start_point_X=210, shot_start_point_Y=50, shot_end_point_X = 460, shot_end_point_Y = 110} 
};

init_part_screenshot{--图片_群名称1--用来在微信界面进行查找
    shot_name = "tupian_qunmingcheng1", 
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/tupian_qunmingcheng1.bmp", 
    shot_area = {shot_start_point_X=120, shot_start_point_Y=120, shot_end_point_X = 460, shot_end_point_Y = 1000} 
};

init_part_screenshot{--图片_联系人名称--截图
    shot_name = "tupian_lianxiren_jietu",   
    shot_path = "/private/var/touchelf/scripts/contact/res/screen_shot/tupian_lianxiren_jietu.bmp", 
    shot_area = {shot_start_point_X=60, shot_start_point_Y=190, shot_end_point_X = 450, shot_end_point_Y = 310} 
};


------------------------------------------------------------------------------------------------------------------------------------------------

init_page{
    page_name = "default_page", 
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/default_page.bmp",
    page_snap_iamge = {} --截图数组，hash数组
};

init_page{
    page_name = "liaotianzhujiemian", --聊天主界面-群聊天
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian.bmp",
    page_snap_iamge = {} --截图数组，hash数组
};

init_page{
    page_name = "liaotianzhujiemian1", --聊天主界面-个人聊天
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/liaotianzhujiemian1.bmp",
    page_snap_iamge = {} --截图数组，hash数组
};

init_page{
    page_name = "weixin_liebiao", --微信_列表
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/weixin_liebiao.bmp",
    page_snap_iamge = {} --截图数组，hash数组
};

init_page{
    page_name = "xiangxi_ziliao", --详细_资料-添加到通讯录
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/xiangxi_ziliao.bmp",
    page_snap_iamge = {} --截图数组，hash数组
};

init_page{
    page_name = "xiangxi_ziliao1", --详细_资料-去打招呼
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/xiangxi_ziliao1.bmp",
    page_snap_iamge = {} --截图数组，hash数组
};