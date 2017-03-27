DESCRIPTION="本脚本为微信自动打招呼"  ;
 
   --[[
      1 num全局变量 打招呼次数，txt也是全局变量 为打招呼内容 ;
      2 有人跟自己打招呼  直接添加为好友
      3 每天不易多进附近的人，不然24小时之内无法使用           
      4 使用本脚本造成的一切问题  一概不负责
   --]]



--点击发现
function  faxian()
    mSleep(1000);
    cicky(388,903);  --点击发现 
    mSleep(500);
end

--进入附近的人
function  fujin()
    mSleep(1000);
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 16, 6, 0x10AEFF, 46, 20, 0xFFFFFF, 92, 9, 0xFFFFFF, 119, 6, 0x000000 }, 90, 40, 534, 159, 554);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
       touchDown(0, x, y);   -- 点击那个点
       mSleep(20);
       touchUp(0);
       mSleep(500);
    else
       cuowu();
    end  
end

---判断是不是第一次进
function  zhidao()
    x,y=findColor(0x0FBC0D);
    if x~=-1 and y~=-1 then
        cicky(x,y)
        mSleep(1000);
    end
end
    
--------------------------------------------------------------------------
--看看有没有人打招呼
function  chakan()
    mSleep(1500);
    x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 39, 2, 0x1AAD19, 91, 2, 0x1AAD19, 160, 2, 0x1AAD19, 245, 3, 0xB9E6B9, 283, 3, 0x1AAD19, 327, 5, 0x1AAD19 }, 90, 162, 769, 489, 774);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        touchDown(0, x, y);   -- 点击那个点
        mSleep(50);
        touchUp(0);
        mSleep(10000);
        jin();          ---进入跟我打招呼的界面 
    end
end

--有人打招呼  就通过
function  jin()
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 45, 2, 0x111112, 79, 0, 0xFFFFFF, 121, 24, 0xFFFFFF, 43, 27, 0xFFFFFF }, 90, 263, 68, 384, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了    --判断是不是在附近的人的界面
        cicky( 594,82  )    --点击点
        mSleep(1000);
        cicky( 316,702   );   --点击附近打招呼的人
        mSleep(2000);      
        for i=1,5 do
            x, y = findMultiColorInRegionFuzzy({ 0x000000, 63, 5, 0xFFFFFF, 78, 6, 0xCFCFCF, 136, -3, 0x242424, 157, 0, 0xFFFFFF, 186, 2, 0x181818, 210, 4, 0xFFFFFF }, 90, 195, 450, 405, 459);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                break 
            end
            yanzheng();       
            mSleep(1000);
            cicky( 73,83);       --返回
            mSleep(1000);
        end
    end 
end

----------判断是不是在附近打招呼的人的界面
function  yanzheng()
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 44, -1, 0x111112, 125, 4, 0xFFFFFF, 136, 1, 0x111112, 170, 1, 0xDBDBDB, 199, 1, 0x676768, 232, 10, 0xFFFFFF, 214, 26, 0x121213, 177, 23, 0x121213, 133, 23, 0x121213, 103, 23, 0x121213, 49, 22, 0x121213, 31, 18, 0x121213 }, 90, 212, 66, 444, 93);
   if x ~= -1 and y ~= -1 then  -- 如果找到了
        mSleep(1000);
        cicky( 268,187 );         ---点击第一个人             
        tongguo();      ---通过
        mSleep(1000);
    else
        cuowu();
    end
end

---发送验证
function  fasong()
    mSleep(1000);
    x, y = findMultiColorInRegionFuzzy({ 0x20D81F, 43, -2, 0x111112, 52, 14, 0x121213, -1, 16, 0x1FD21E, 14, 9, 0x1B961A, 46, 8, 0x186317 }, 90, 562, 70, 615, 88);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        mSleep(500);
        cicky(582,250);          --点击叉叉
        mSleep(500);
        inputText("你好呀");
        mSleep(1500);
        touchDown(0, x, y);   -- 点击发送
        mSleep(50);
        touchUp(0);
        mSleep(8000);
    end
end

----通过验证
function  tongguo()
    mSleep(2000);
    rotateScreen(0);
    mSleep(703);
    touchDown(2, 316, 656)
    mSleep(7);
    touchMove(2, 318, 648)
    mSleep(35);
    touchMove(2, 318, 620)
    mSleep(17);
    touchMove(2, 320, 570)
    mSleep(8);
    touchMove(2, 324, 512)
    mSleep(25);
    touchMove(2, 328, 426)
    mSleep(14);
    touchMove(2, 336, 342)
    mSleep(1);
    touchMove(2, 348, 264)
    mSleep(16);
    touchMove(2, 358, 192)
    mSleep(15);
    touchMove(2, 364, 144)
    mSleep(17);
    touchMove(2, 374, 98)
    mSleep(17);
    touchMove(2, 396, 48)
    mSleep(16);
    touchMove(2, 436, 8)
    mSleep(17);
    touchMove(2, 502, 0)
    mSleep(16);
    touchUp(2)
    mSleep(2000);
    x,y=findColor(0x1AAD19)
    if x~=-1 and y~=-1 then
        cicky(x,y);     ---点击通过
        mSleep(6000);
        fasong();         ---判断需不需要发送
        mSleep(500);
        cicky(  90,82  )    --点击返回
        mSleep(500);
        rotateScreen(0);
        mSleep(1016);
        touchDown(9, 424, 180)
        mSleep(4);
        touchMove(9, 414, 180)
        mSleep(16);
        touchMove(9, 388, 180)
        mSleep(66);
        touchMove(9, 354, 180)
        mSleep(15);
        touchMove(9, 314, 178)
        mSleep(2);
        touchMove(9, 276, 176)
        mSleep(13);
        touchMove(9, 244, 176)
        mSleep(2);
        touchMove(9, 216, 180)
        mSleep(2);
        touchMove(9, 188, 192)
        mSleep(13);
        touchUp(9)
        mSleep(500);
        cicky( 589,192 );   --点击删除
        mSleep(1000);
    end    
end

 ---------------------------------------------------------------   --------------------------------
    
    --没有人打招呼
--判断是不是在附近的人的界面
function  jia()
    mSleep(10000);
    x, y = findMultiColorInRegionFuzzy({ 0x808080, 46, 0, 0x121212, 306, 0, 0x121212, 334, 2, 0xFFFFFF, 351, 2, 0xFFFFFF, 108, 5, 0xE7E7E7, 83, 5, 0xF8F8F8 }, 90, 259, 82, 610, 87);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
    mSleep(1000);
    else
       cuowu();
    end
end

---点击人  打招呼
function  dazhaohu()
    mSleep(1000);
    cicky(  303,190  );   --点击人
    mSleep(2000);
    rotateScreen(0);
    mSleep(315);
    touchDown(2, 322, 710)
    mSleep(2);
    touchMove(2, 320, 688)
    mSleep(14);
    touchMove(2, 320, 658)
    mSleep(2);
    touchMove(2, 320, 612)
    mSleep(14);
    touchMove(2, 320, 562)
    mSleep(1);
    touchMove(2, 324, 504)
    mSleep(109);
    touchMove(2, 332, 420)
    mSleep(2);
    touchMove(2, 350, 336)
    mSleep(2);
    touchMove(2, 368, 260)
    mSleep(3);
    touchMove(2, 386, 184)
    mSleep(1);
    touchMove(2, 402, 106)
    mSleep(14);
    touchMove(2, 420, 44)
    mSleep(2);
    touchMove(2, 442, 10)
    mSleep(2);
    touchMove(2, 476, 0)
    mSleep(11);
    touchUp(2)

    mSleep(2000);
    ------判断是不是朋友了     打招呼
    x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 37, 2, 0x92D892, 91, 2, 0x1AAD19, 79, 34, 0x1AAD19, 28, 32, 0x1AAD19, 1, 32, 0x1AAD19, 15, 32, 0x9FDD9E }, 90, 275, 704, 366, 738);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
     touchDown(0, x, y);   -- 点击打招呼
     mSleep(50);
     touchUp(0);
     mSleep(2000);
     inputText(txt);
     mSleep(2000);
     cicky( 593,70  );    --点击发送
     mSleep(8000);
    end
end
    
-- 返回继续打招呼
function  fanhui()
    mSleep(1000);
   x, y = findMultiColorInRegionFuzzy({ 0x111112, 31, 2, 0x515152, 48, -1, 0x111112, 42, 21, 0x787879, 6, 25, 0xA9A9AA, -24, 20, 0x121213, -37, 12, 0x121212, -25, 5, 0xFFFFFF, -27, 9, 0xFFFFFF }, 90, 21, 69, 106, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
       touchDown(0, x, y);   -- 点击返回
       mSleep(50);
       touchUp(0);
       mSleep(1000);
    end   
end

--滑动一下 就是刷新
function  hua()
    rotateScreen(0);
    mSleep(1349);
    touchDown(8, 346, 522)
    mSleep(249);
    touchMove(8, 350, 514)
    mSleep(1);
    touchMove(8, 350, 512)
    mSleep(1);
    touchMove(8, 350, 510)
    mSleep(1);
    touchMove(8, 350, 508)
    mSleep(2);
    touchMove(8, 350, 506)
    mSleep(2);
    touchMove(8, 350, 504)
    mSleep(31);
    touchMove(8, 350, 502)
    mSleep(15);
    touchMove(8, 350, 500)
    mSleep(113);
    touchMove(8, 350, 498)
    mSleep(16);
    touchMove(8, 350, 496)
    mSleep(1);
    touchMove(8, 352, 494)
    mSleep(32);
    touchMove(8, 352, 492)
    mSleep(16);
    touchMove(8, 352, 490)
    mSleep(22);
    touchMove(8, 352, 490)
    mSleep(1);
    touchMove(8, 354, 488)
    mSleep(17);
    touchMove(8, 354, 486)
    mSleep(17);
    touchMove(8, 354, 484)
    mSleep(17);
    touchMove(8, 356, 482)
    mSleep(16);
    touchMove(8, 356, 480)
    mSleep(32);
    touchMove(8, 356, 478)
    mSleep(17);
    touchMove(8, 358, 476)
    mSleep(1);
    touchMove(8, 358, 474)
    mSleep(17);
    touchMove(8, 358, 472)
    mSleep(16);
    touchMove(8, 360, 472)
    mSleep(17);
    touchMove(8, 360, 470)
    mSleep(17);
    touchMove(8, 360, 470)
    mSleep(17);
    touchMove(8, 360, 468)
    mSleep(16);
    touchMove(8, 362, 466)
    mSleep(31);
    touchMove(8, 362, 466)
    mSleep(90);
    touchMove(8, 362, 464)
    mSleep(1);
    touchMove(8, 362, 462)
    mSleep(1);
    touchMove(8, 364, 462)
    mSleep(1);
    touchMove(8, 364, 460)
    mSleep(2);
    touchMove(8, 364, 460)
    mSleep(1);
    touchMove(8, 364, 458)
    mSleep(16);
    touchMove(8, 366, 452)
    mSleep(29);
    touchMove(8, 366, 452)
    mSleep(1);
    touchMove(8, 368, 452)
    mSleep(11);
    touchMove(8, 368, 450)
    mSleep(48);
    touchMove(8, 368, 450)
    mSleep(1);
    touchMove(8, 368, 448)
    mSleep(32);
    touchMove(8, 368, 448)
    mSleep(18);
    touchMove(8, 368, 446)
    mSleep(15);
    touchMove(8, 370, 446)
    mSleep(14);
    touchMove(8, 370, 446)
    mSleep(33);
    touchMove(8, 370, 444)
    mSleep(16);
    touchMove(8, 370, 444)
    mSleep(29);
    touchMove(8, 370, 444)
    mSleep(2);
    touchMove(8, 370, 442)
    mSleep(33);
    touchMove(8, 370, 442)
    mSleep(1);
    touchMove(8, 370, 440)
    mSleep(28);
    touchMove(8, 370, 440)
    mSleep(41);
    touchMove(8, 372, 438)
    mSleep(2);
    touchMove(8, 372, 438)
    mSleep(25);
    touchMove(8, 372, 436)
    mSleep(27);
    touchMove(8, 372, 436)
    mSleep(17);
    touchMove(8, 372, 436)
    mSleep(1);
    touchMove(8, 372, 434)
    mSleep(33);
    touchMove(8, 372, 434)
    mSleep(16);
    touchMove(8, 372, 432)
    mSleep(15);
    touchMove(8, 374, 432)
    mSleep(33);
    touchMove(8, 374, 430)
    mSleep(18);
    touchMove(8, 374, 430)
    mSleep(16);
    touchMove(8, 374, 430)
    mSleep(14);
    touchMove(8, 374, 428)
    mSleep(25);
    touchMove(8, 374, 428)
    mSleep(46);
    touchMove(8, 374, 426)
    mSleep(11);
    touchMove(8, 376, 426)
    mSleep(12);
    touchMove(8, 376, 424)
    mSleep(182);
    touchMove(8, 376, 424)
    mSleep(3);
    touchMove(8, 376, 422)
    mSleep(8);
    touchMove(8, 376, 422)
    mSleep(16);
    touchMove(8, 378, 422)
    mSleep(2);
    touchMove(8, 378, 420)
    mSleep(16);
    touchMove(8, 378, 420)
    mSleep(12);
    touchMove(8, 378, 418)
    mSleep(9);
    touchMove(8, 378, 418)
    mSleep(7);
    touchMove(8, 378, 416)
    mSleep(3);
    touchMove(8, 378, 414)
    mSleep(2);
    touchMove(8, 380, 414)
    mSleep(16);
    touchMove(8, 380, 412)
    mSleep(12);
    touchMove(8, 382, 412)
    mSleep(3);
    touchMove(8, 382, 410)
    mSleep(12);
    touchMove(8, 382, 410)
    mSleep(24);
    touchMove(8, 382, 408)
    mSleep(15);
    touchMove(8, 382, 408)
    mSleep(9);
    touchMove(8, 382, 408)
    mSleep(31);
    touchMove(8, 382, 406)
    mSleep(35);
    touchMove(8, 384, 406)
    mSleep(2);
    touchMove(8, 384, 404)
    mSleep(29);
    touchMove(8, 384, 404)
    mSleep(33);
    touchMove(8, 384, 402)
    mSleep(2);
    touchMove(8, 384, 402)
    mSleep(31);
    touchMove(8, 386, 400)
    mSleep(28);
    touchMove(8, 386, 400)
    mSleep(18);
    touchMove(8, 386, 398)
    mSleep(35);
    touchMove(8, 386, 398)
    mSleep(16);
    touchMove(8, 386, 396)
    mSleep(14);
    touchMove(8, 388, 396)
    mSleep(18);
    touchMove(8, 388, 396)
    mSleep(33);
    touchMove(8, 388, 394)
    mSleep(16);
    touchMove(8, 388, 394)
    mSleep(14);
    touchMove(8, 388, 394)
    mSleep(28);
    touchMove(8, 388, 392)
    mSleep(1);
    touchMove(8, 390, 392)
    mSleep(38);
    touchMove(8, 390, 392)
    mSleep(11);
    touchMove(8, 390, 390)
    mSleep(32);
    touchMove(8, 390, 390)
    mSleep(1);
    touchMove(8, 390, 390)
    mSleep(37);
    touchMove(8, 390, 388)
    mSleep(10);
    touchMove(8, 390, 388)
    mSleep(40);
    touchMove(8, 392, 388)
    mSleep(2);
    touchMove(8, 392, 386)
    mSleep(36);
    touchMove(8, 392, 386)
    mSleep(48);
    touchMove(8, 392, 384)
    mSleep(20);
    touchMove(8, 392, 384)
    mSleep(33);
    touchMove(8, 394, 382)
    mSleep(46);
    touchMove(8, 394, 382)
    mSleep(65);
    touchMove(8, 394, 380)
    mSleep(29);
    touchMove(8, 394, 380)
    mSleep(158);
    touchMove(8, 394, 380)
    mSleep(69);
    touchMove(8, 394, 378)
    mSleep(15);
    touchMove(8, 396, 378)
    mSleep(129);
    touchMove(8, 396, 378)
    mSleep(65);
    touchMove(8, 396, 376)
    mSleep(80);
    touchMove(8, 396, 376)
    mSleep(58);
    touchMove(8, 396, 374)
    mSleep(51);
    touchMove(8, 398, 374)
    mSleep(34);
    touchMove(8, 398, 374)
    mSleep(918);
    touchUp(8)
    mSleep(1000);
end

--循环添加
function  xunhuan()
    x, y = findMultiColorInRegionFuzzy({ 0x8C8C8C, 19, 4, 0xF5F5F5, 26, 10, 0x121213, 53, 10, 0x121213, 76, 10, 0x121213, 110, 8, 0x121213, 75, -5, 0xFFFFFF, 124, -2, 0xFFFFFF, 120, 14, 0x121213, 53, -12, 0x111112 }, 90, 250, 68, 374, 94);
   if x ~= -1 and y ~= -1 then  -- 如果找到了
        dazhaohu();
        mSleep(1000);
        fanhui();
        mSleep(math.random(3000,10000));
        hua();
    else
        cuowu();
    end
end

function fujinrendazhaohu()
    jiesuo();      --解锁
    dakai();       --打开微信
    
    tongzhi();     --等待1s
    hao();         --点击通知
    tongzhi();

    faxian();      --进入发现
    tongzhi();     
    fujin();       --进入附近的人
    tongzhi();
    zhidao();
    tongzhi();
    chakan();    --看看有没人打招呼
    tongzhi();
    jia();       
    tongzhi();
    for i=1,num,1 do   --循环加人
        xunhuan();
        tongzhi();
        x, y = findMultiColorInRegionFuzzy({ 0x808080, 46, 0, 0x121212, 306, 0, 0x121212, 334, 2, 0xFFFFFF, 351, 2, 0xFFFFFF, 108, 5, 0xE7E7E7, 83, 5, 0xF8F8F8 }, 90, 259, 82, 610, 87);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
           tongzhi();
           mSleep(math.random(0,2000));
        else
           cuowu();
        end
    end
end

--界面错误
 function cuowu()
    mSleep(500);
    notifyMessage("界面错误");
    mSleep(1000);
    appKill("com.tencent.xin");  --关闭微信软件
    fujinrendazhaohu();
end

---------------------------
function weixin_operate()
    ---mSleep(10000);
    logFileInit(sl_log_file);
    local current_page = get_current_page(); --得到当前的page
    if false ~= current_page then 
       page_array[current_page]:enter(); --直接进当前页面的处理
    else
       page_array["page_main"]:enter();
    end
end


fujinrendazhaohu();