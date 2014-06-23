local Board = import("..view.Board")	--方块容器

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.bg = display.newSprite("#1024.png",display.cx,display.cy)
    self:addChild(self.bg)

    self.board = Board.new()
    self.addChild(self.board)
    self.addEventListener("GAME_COMPLETE", handle(self,self.GameComplete))
    self.addEventListener("GAME_FAIL", handle(self,self.GameFail))
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
