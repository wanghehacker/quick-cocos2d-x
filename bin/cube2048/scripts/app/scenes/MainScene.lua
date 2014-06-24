local Board = import("..view.Board")	--方块容器

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.bg = display.newSprite("#1024bg.png",display.cx,display.cy)
    self:addChild(self.bg)

    self.cube = display.newSprite("#cubebg.png",display.cx,display.cy - 80)
    self:addChild(self.cube)

    self.board = Board.new()
    self:addChild(self.board)
    self.board:setPosition(display.cx - 275,display.cy - 80 - 275)
    self.board:addEventListener("GAME_COMPLETE", handler(self,self.GameComplete))
    self.board:addEventListener("GAME_FAIL", handler(self,self.GameFail))
    --正在移动的标志 在移动中 不处理鼠标事件上
    self.moving = false
end

--游戏完成
function MainScene:GameComplete()

end

--游戏结束
function MainScene:GameFail()
end
--开始游戏了
function MainScene:onEnter()
	self.board:start()
    self.cube:setTouchEnabled(true)
    --self.cube:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    self.cube:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
        -- 触摸事件
        -- 判断方向吧少年
        if event.name == "moved" then
            --正在移动中 不处理事件
            if self.moving then
                return
            end
            self.moving = true
            local dx = event.x - event.prevX
            local dy = event.y - event.prevY
            if math.abs(dx) > math.abs(dy) then
                if dx > 0 then
                    --右
                    print("右")
                    self.board:slip(3,handler(self,self.slipComplete))
                else
                    --左
                    print("左")
                    self.board:slip(2,handler(self,self.slipComplete))
                end
            else
                if dy>0 then
                    --上
                    print("上")
                    self.board:slip(1,handler(self,self.slipComplete))
                else
                    --下
                    print("下")
                    self.board:slip(4,handler(self,self.slipComplete))
                end
            end
        end
        return true
    end)
end

--滑动完成回调
function MainScene:slipComplete()
    -- body
    self.moving = false
end

function MainScene:onExit()
    
end

return MainScene
