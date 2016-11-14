function class_liaotianzhujiemian_page:action() ---动作---
    if self.card_index == 0 and self.page_index ==0 then
        move_up();
        mSleep(200);
    end
    
    if ( self.card_index == 4 ) then  --0~3
        self.page_index = (self.page_index + 1) % 4  --只翻3页&3次
        if self.page_index == 0 then
            self.page_index = 0;
            self.card_index = 0;
            init_page_stack(); ---清空所有的信息---------------------------------终结者------------------
            return;
        end       
        move_down();  ---往上翻页--      
    end
    self.card_index = self.card_index % 4;
    
    local x = 320; local y = (point_array["end"].y - (self.card_index*280) ); --1020
    click(x, y); --点击屏幕
    mSleep(1000);
    self.card_index = self.card_index + 1;
    
    if false == enter_page("xiangxi_ziliao") then
        if true == self:check_page() then  --如果点到空气
            self:action();  --重新进入处理
        else
            click_point("fanhui"); ---比如进网页，则点返回
            mSleep(1000);
            if true == self:check_page() then
               self:action();  --重新进入处理
            else
                error_info("鬼知道点到了什么");
            end      
        end      
    end
end