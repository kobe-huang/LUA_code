SCREEN_RESOLUTION="960*640";
SCREEN_COLOR_BITS=32;

--封装
function cicky(x,y)
    touchDown(0,x,y);
    mSleep(100);
    touchUp(0);
end

function zs(x1,y1,a,x2,y2,b)--找色判断函数
    x = getColor(x1, y1);
    y = getColor(x2, y2);    
    if x==a and y==b then
        cicky(x1,y1);
        mSleep(300);         
    end
    mSleep(200);        
end

----系统通知
function  tongzhi()
    zs( 447,553 ,0x017AFF, 460,572, 0x61A9F9);         --通知好
    zs ( 296,546 ,0x007AFF, 340,569 ,0x3F99FC);        --电量不足
    zs( 312,561 ,0xF6F6F6, 325,590 ,0x63ABFB);         --通知好
    zs( 236,580 ,0x007AFF, 189,578 ,0xF4F4F4);         --通知不再提示
    zs(  160,563 ,0x4B9FFC, 213,591 ,0x419AFC);        --信任
end

--解锁
function jiesuo()
       --屏幕激活
    keyDown('HOME');
    mSleep(100);
    keyUp('HOME');
    mSleep(2000);
    x, y = findMultiColorInRegionFuzzy({ 0x97CCDF, 27, 1, 0x98D1E2, 58, 2, 0x94CFE0, 304, -4, 0x96C0CC, 328, -18, 0xA2CAD3, 327, 1, 0x9DC6D2, 291, -20, 0xA3CCD4 }, 90, 289, 913, 617, 935);
   if x ~= -1 and y ~= -1 then  -- 如果找到了
    rotateScreen(0);
    mSleep(1070);
    touchDown(7, 100, 602)
    mSleep(39);
    touchMove(7, 108, 606)
    mSleep(16);
    touchMove(7, 120, 606)
    mSleep(35);
    touchMove(7, 134, 608)
    mSleep(16);
    touchMove(7, 156, 608)
    mSleep(2);
    touchMove(7, 180, 610)
    mSleep(14);
    touchMove(7, 208, 610)
    mSleep(16);
    touchMove(7, 246, 610)
    mSleep(17);
    touchMove(7, 300, 610)
    mSleep(16);
    touchMove(7, 356, 606)
    mSleep(18);
    touchMove(7, 414, 604)
    mSleep(16);
    touchMove(7, 476, 604)
    mSleep(18);
    touchMove(7, 536, 602)
    mSleep(17);
    touchMove(7, 608, 600)
    mSleep(16);
    touchMove(7, 634, 592)
    mSleep(17);
    touchUp(7)
    else
       mSleep(100);
    end   
end

--打开微信
function  dakai()
    appKill("com.tencent.xin");  --关闭微信
    mSleep(1000);
    appRun("com.tencent.xin"); -- 打开微信
    mSleep(10000);

end

--点击通知 好 
 function hao()
     mSleep(10000);
     x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 11, 0, 0xA1CAF8, 17, 0, 0xF5F5F5, 27, -1, 0xF5F5F5 }, 90, 307, 571, 334, 572);
     if x ~= -1 and y ~= -1 then  -- 如果找到了
        touchDown(0, x, y);   -- 点击那个点
        mSleep(20);
        touchUp(0);
        mSleep(2000);        
    end
        
end