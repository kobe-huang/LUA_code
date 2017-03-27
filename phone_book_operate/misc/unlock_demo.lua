--滑动函数
    my_finger = 2;   
function move(x, y, x1, y1) --封装一个滑动的参数---           
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
    
    local x_step = 0;
    local y_step = 0;
    
	--touchDown(my_finger, x, y)
	mSleep(10)
   
    x_step = math.modf(xx/10);--15
    y_step = math.modf(yy/10);--15
    --
    if  0 == x_step then x_step =1 end;
    if  0 == y_step then y_step =1 end;        
    
    --touchDown(my_finger, x, y);
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
    --touchUp(my_finger);
end

--分别列出点的坐标

point_1 = {
	x = 220,
	y = 630	
};
point_2 = {
	x = 420,
	y = 630	
};
point_3 = {
	x = 220,
	y = 830	
};
point_4 = {
	x = 420,
	y = 830	
};

point = {point_1, point_2, point_3, point_4};

function line_1_to_2()
	x, y =  findMultiColorInRegionFuzzy({ 0x9E9C9E }, 90, 257, 632, 257, 632);
	if x ~= -1 and y ~= -1 then  -- 如果找到了
	     return 1
	 else
	 	return 0;
	end
end 
function line_1_to_3()
	x, y = findMultiColorInRegionFuzzy({ 0x9F9F9F }, 90, 220, 663, 220, 663);
	if x ~= -1 and y ~= -1 then  -- 如果找到了
	     return 1
	 else
	 	return 0;
	end
end 
function line_1_to_4()
	x, y = findMultiColorInRegionFuzzy({ 0x9E9F9E }, 90, 244, 656, 244, 656);
	if x ~= -1 and y ~= -1 then  -- 如果找到了
	     return 1
	 else
	 	return 0;
	end
end 

function line_2_to_3()
	x, y =  findMultiColorInRegionFuzzy({ 0x979897 }, 90, 397, 655, 397, 655);
	if x ~= -1 and y ~= -1 then  -- 如果找到了
	     return 1
	 else
	 	return 0;
	end
end 

function line_2_to_4()
	x, y = findMultiColorInRegionFuzzy({ 0xA7A5A7 }, 90, 420, 667, 420, 667);
	if x ~= -1 and y ~= -1 then  -- 如果找到了
	     return 1
	 else
	 	return 0;
	end
end 

function line_3_to_4()
	x, y =  findMultiColorInRegionFuzzy({ 0xA7A7A7 }, 90, 260, 832, 260, 832);
	if x ~= -1 and y ~= -1 then  -- 如果找到了
	     return 1
	 else
	 	return 0;
	end
end 

connect_array = {}

function init_connect_array() --初始化连接性
	connect_array[1] = {};
	connect_array[2] = {};
	connect_array[3] = {};
	connect_array[4] = {};

	connect_array[1][1] = -1
	connect_array[2][2] = -1
	connect_array[3][3] = -1
	connect_array[4][4] = -1

	connect_array[1][2] = line_1_to_2();
	connect_array[1][3] = line_1_to_3();
	connect_array[1][4] = line_1_to_4();

	connect_array[2][1] = line_1_to_2();
	connect_array[2][3] = line_2_to_3();
	connect_array[2][4] = line_2_to_4();

	connect_array[3][1] = line_1_to_3();
	connect_array[3][2] = line_2_to_3();
	connect_array[3][4] = line_3_to_4();

	connect_array[4][1] = line_1_to_4();
	connect_array[4][2] = line_2_to_4();
	connect_array[4][3] = line_3_to_4();
end

function check_connect(m, n) --检测 m 和 n之间是否有连接
	return connect_array[m][n];
	-- body
end

---step1：第一步找出这些连线,找出连接的数组. 找出map
point_map = {}; 
function find_line_connect( ... ) --图案是由3条线组成的
	-- body
	local xxx = {};
	--local begin_point = 1;
	xxx[1] = line_1_to_2() + line_1_to_3() + line_1_to_4(); --点1的，连接线数目
	xxx[2] = line_1_to_2() + line_2_to_3() + line_2_to_4();
	xxx[3] = line_1_to_3() + line_2_to_3() + line_3_to_4();
	xxx[4] = line_1_to_4() + line_2_to_4() + line_3_to_4();
	
	for i,v in ipairs(xxx) do  --找出起始点和结束点
		if v == 1 then         --找到只有一个连出线的点
			if point_map[1] == nil then
				point_map[1] = i     --起始点（暂时还没有排顺序，顺序由step2 来确定）
				for m=1, 4 do
					if 1 == check_connect(m, i) then
						point_map[2] = m;
					end
				end
			else
				point_map[4] = i; --结束点
				for n=1, 4 do
					if 1 == check_connect(n, i) then
						point_map[3] = n;
					end
				end
			end
		end
	end
end

---step2：找出方向，通过判断箭头，的颜色的深浅
function  ldzc(c1,i1,j1,c2,m,x1,y1,x2,y2)   --多点模糊找色
    x, y = findMultiColorInRegionFuzzy({c1,i1,j1,c2},m,x1,y1,x2,y2);
end

function check_direct( ... )
    --先判断横竖
    --yyy[2]
    if line_3_to_4() == 1 then
        ldzc(0xD2D4D2, -1, -16, 0xCFD0CF, 90, 324, 825, 325, 841);
        if x>0 then
            return 4,3
        else
            return 3,4 
        end
    end
    if line_1_to_2() == 1 then
        ldzc(0x989798, 0, -13, 0xB8B9B8, 90, 317, 625, 317, 638);
        if x>0 then
            return 1, 2 
        else
            return 2, 1 
        end
    end
    if line_2_to_4() == 1 then
        ldzc(0xD4D3D4, -15, 0, 0xBEBDBE, 90, 412, 728, 427, 728);
        if x>0 then
            return 2, 4 
        else
            return 4, 2 
        end
    end
    if line_1_to_3() == 1 then
        ldzc(0xCDCBCD, -14, 0, 0xA2A1A2, 90, 214, 736, 228, 736);
        if x>0 then
            return 3, 1 
        else
            return 1,3  
        end
    end
end

function find_direct( ... )
	-- body
	--先判断 横&竖，直接拿第二个点来判断
	--横线&竖线 无非1-2，2-4，3-4，1-3 
	point1, point2 = check_direct();
	for i=1,3 do
		if point_map[i] == point1 then
			if point_map[i+1] ==  point2 then
				return true;
			else
				return false
            end
		end
	end
end


---step3：滑动解锁: 从 point_map[1] --> point_map[4] 或 point_map[4] --> point_map[1]
function unlock( ... )
	my_map = {};
	if true == find_direct() then --方向是正的
		my_map = point_map;
	else
		my_map[1] = point_map[4];
		my_map[2] = point_map[3];
		my_map[3] = point_map[2];
		my_map[4] = point_map[1];
	end
	touchDown(my_finger, point[my_map[1]].x , point[my_map[1]].y);
	move(point[my_map[1]].x ,  point[my_map[1]].y, point[my_map[2]].x ,  point[my_map[2]].y)
	move(point[my_map[2]].x ,  point[my_map[2]].y, point[my_map[3]].x ,  point[my_map[3]].y)
	move(point[my_map[3]].x ,  point[my_map[3]].y, point[my_map[4]].x ,  point[my_map[4]].y)
	touchUp(my_finger);
	-- body
end

function main()
    unlock()
end