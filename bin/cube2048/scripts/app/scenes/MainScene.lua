local Board = import("..view.Board")	--方块容器
local TitleBar = import("..view.TitleBar")
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.bg = display.newScale9Sprite("#1024bg.png",5,5,cc.size(1,1))
    self.bg:setContentSize(cc.size(display.widthInPixels,display.heightInPixels))
    self.bg:setPosition(display.cx,display.cy)
    self:addChild(self.bg)

    --标题 分值面板
    self.title = TitleBar.new()
    self:addChild(self.title)
    self.title:setPosition(display.cx - 275,display.top - 200)

    --格子背景
    self.cube = display.newSprite("#cubebg.png",display.cx,display.cy - 80)
    self:addChild(self.cube)
    --
    self.board = Board.new()
    self:addChild(self.board)
    self.board:setPosition(display.cx - 275,display.cy - 80 - 275)
    self.board:addEventListener("GAME_COMPLETE", handler(self,self.GameComplete))   --游戏胜利
    self.board:addEventListener("GAME_FAIL", handler(self,self.GameFail))           --游戏失败
    self.board:addEventListener("GAME_ADD_SCORE", handler(self,self.addScore))      --游戏加分
    --正在移动的标志 在移动中 不处理鼠标事件上
    self.moving = false
    --当前分值 最高分
    self.score = 0
    self.best = 65535
end

--游戏完成
function MainScene:GameComplete()

end

--游戏结束
function MainScene:GameFail()
end
--开始游戏了
function MainScene:onEnter()
    self:gameStart()
    self.cube:setTouchEnabled(true)
    --self.cube:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    self.cube:addNodeEventListener(cc.NODE_TOUCH_EVENT, function (event)
        --dump(event)
        -- 触摸事件
        -- 判断方向吧少年
        if event.name == "began" then
            self.bx = event.x    --触摸开始的点坐标x
            self.by = event.y    --触摸开始的点坐标y
            self.touchcount = 0  --触摸点的次数 
        elseif event.name == "moved" then
            --正在移动中 不处理事件
            if self.moving == true or self.touchcount ~=3 then
                -- print("正在移动中")
                if self.touchcount < 3 then
                    self.touchcount = self.touchcount + 1
                end
                return --返回
            end
            --正在移动
            self.moving = true

            --判断运动
            local dx = event.x - self.bx
            local dy = event.y - self.by
            if math.abs(dx) > math.abs(dy) then
                if dx > 0 then
                    --右
                    print("右")
                    self.board:slip(4,handler(self,self.slipComplete))
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
                    self.board:slip(3,handler(self,self.slipComplete))
                end
            end
        elseif event.name == "ended" then
            self.moving = false
            --self.touchcount = 0
        end
        return true
    end)
end


function MainScene:gameStart()
    local best = CCUserDefault:sharedUserDefault():getIntegerForKey("bestscore")
    if best == nil then 
        best = 0
        CCUserDefault:sharedUserDefault():setIntegerForKey("bestscore", 0)
    end
    --初始化分数
    self.score = 0
    self.best = best
    self.board:start()
end


--游戏加分
function MainScene:addScore(event)
    self.score = self.score + tonumber(event.score)
    self.title:setScore(self.score)

    if self.score > self.best then
        CCUserDefault:sharedUserDefault():setIntegerForKey("bestscore", self.score)
        self.title:setBestScore(self.score)
    end
end


--滑动完成回调
function MainScene:slipComplete()
    -- body
    if self.board:addOneCube() then
        print("继续")
    else
        print("输了")
    end
end

function MainScene:onExit()
    
end

return MainScene
