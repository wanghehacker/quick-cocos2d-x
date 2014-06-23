local Cube = import("")
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


--刷新一下界面
--随机刷两个cube出来
--随机选2 或4 ，如果是2则两个都是2，如果是4则两个都是4
--
function Board:start()
	math.randomseed(os.time())
	local rand = math.random(2)
	local value = 2
	if rand == 1 then
		--随机两个2
		value = 2
	else
		--随机两个4
		value = 2
	end

	--随机出坐标
	local posx = math.random(4)
	local posy = math.random(4)

	--TODO 添加cube
	
end

--在指定的坐标添加cube
function Board:addCube(value,posx,posy)
	local cube = 
end

return Board