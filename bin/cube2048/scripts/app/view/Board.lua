
--所有格子的容器
local Board = class("Board", function ()
	return display.newLayer()
end)


--构造
function Board:ctor()
	cc.GameObject.extend(self):addComponent("components.behavior.EventProtocol"):exportMethods()
	self.batch = display.newBatchNode(GAME_TEXTURE_IMAGE_FILENAME)
	self.batch:setPosition(display.cx, display.cy)
    self:addChild(self.batch)
    
end
