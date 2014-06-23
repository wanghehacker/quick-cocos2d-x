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
    self.board:addEventListener("GAME_COMPLETE", handler(self,self.GameComplete))
    self.board:addEventListener("GAME_FAIL", handler(self,self.GameFail))
end

--游戏完成
function MainScene:GameComplete()

end

--游戏结束
function MainScene:GameFail()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
