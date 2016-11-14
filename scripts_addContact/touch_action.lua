
function error_info(out_info)  ---错误处理函数
    --notifyMessage(out_info);
    
        writeStrToFile("+++error:  " .. out_info , log_file_name);
        
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(5000);
    reset_function();
        
    run_function();
    --os.exit(1);
end

function click(x, y,finger)  ---点击----
    local my_finger = 0;
    if finger ~= nil and "number" == type(finger) then
        my_finger = finger;
    end
	touchDown(my_finger, x, y);
	mSleep(100);
	touchUp(my_finger);
end

function click_point(point_name)
    click(point_array[point_name].x, point_array[point_name].y);
end
    
    
function move(x, y, x1, y1, finger, speed) --封装一个滑动的参数---    
    if x == x1 or y == y1 then
        return nil
    end  
    
    local my_finger = 0;
    if finger ~= nil and "number" == type(finger) then
        my_finger = finger;
    end
    
    local xx =  x1-x;  --步幅
    local yy =  y1-y;  --步幅
    local xx1 = 0; local yy1 = 0;
    
    if xx <= 0 then
        xx1 = -xx;
    else
        xx1 = xx;
    end
    if yy <= 0 then
        yy1 = -yy;
    else
        yy1 = yy;
    end 
    if xx1 < 30 or yy1 <30 then
        notifyMessage("+++划动区间太小,建议设置大点++++");
    end   
    
    local x_step = 0;
    local y_step = 0;
    
	touchDown(my_finger, x, y)
	mSleep(10)
    if speed == "fast" then
        x_step = math.modf(xx/10);--15
        y_step = math.modf(yy/10);--15
    elseif speed == "slow" then
        x_step = math.modf(xx/80);
        y_step = math.modf(yy/80);
    else  
        x_step = math.modf(xx/18); --30
        y_step = math.modf(yy/18); --30
    end
    --
    if  0 == x_step then x_step =1 end;
    if  0 == y_step then y_step =1 end;        
    
    touchDown(my_finger, x, y);
    local _ = 0
    for  _ =1, 30  do
        
        mSleep(18);
        x = x + x_step;
        y = y + y_step;
        if x <=0 or x >= 640 or y <=0 or y >= 1136 then
            break;
        end
        touchMove(my_finger, x, y)
    end  
    touchUp(my_finger);
end
--

function move_up()
    move(360, 800, 400, 500);
end

function move_down()
    move(360, 420, 400, 760);
end

function move_up_page()  --一个页面--
    move(360, 1000, 400, 200);
end

function move_down_page()---一个页面
    move(360, 200, 400, 1000);
end

function move_left()
    move(440, 600, 120, 760);
end

function move_right()
    move(120, 600, 440, 760);
end
