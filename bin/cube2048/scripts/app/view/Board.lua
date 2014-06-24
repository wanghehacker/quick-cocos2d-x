local Cube = import("..view.Cube")
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
    --数组长度
    self.cubes = {}
    self.cubepos = {}

end

--刷新一下界面
--随机刷两个cube出来
--随机选2 或4 ，如果是2则两个都是2，如果是4则两个都是4
function Board:start()
	math.randomseed(os.time())
	local rand = math.random(2)
	local value = 2
	if rand == 1 then
		--随机两个2
		value = 2
	else
		--随机两个4
		value = 4
	end

	--随机出坐标
	local posx = nil
	local posy = nil
	posx,posy = self:getNewPosition()
	print("posx "..posx)
	print("posy "..posy)
	if posx == 0 then
		return
	end
	--添加cube
	self:addCube(value, posx, posy)

	--第二个CUBE
	posx,posy = self:getNewPosition()
	print("posxx "..posx)
	print("posyy "..posy)
	if posx == 0 then
		return 
	end
	--添加cube
	self:addCube(value, posx, posy)
end

--获取一个未被占用的位置
function Board:getNewPosition()
	local x = 0
	local y = 0
	local comp = true
	--如果格子不满的话 则获取位置
	--格子满了  就返回 0 0 
	if #self.cubes < 16 then
		while true do
			x = math.random(4)
			y = math.random(4)
			for i,v in pairs(self.cubes) do
				if v.x == x and v.y == y then
					comp = false
					break
				end
			end
			if comp then
				break
			else
				comp = true
			end
		end
	end
	return x,y
end

--在指定的坐标添加cube
--坐标系啊 草泥马
--CCSprite 默认锚点在中心
--
function Board:addCube(value,posx,posy)
	local cube = Cube.new(value)
	--xy 是GL坐标
	local x = (posx - 1) * (CUBE_WIDTH + CUBE_ROW_PADDING) + CUBE_LEFT_PADDING + CUBE_WIDTH*0.5
	local y = (posy - 1) * (CUBE_HEIGHT + CUBE_COL_PADDING) + CUBE_TOP_PADDING + CUBE_HEIGHT*0.5
	--cube x y 存的是矩阵坐标 1-4 1-4
	cube.x = posx
	cube.y = posy
	cube:setPosition(x,y)
	self:addChild(cube)
	--保存起来
	table.insert(self.cubes, cube)
	--用二维数组存储
	if self.cubepos[x] == nil then
		self.cubepos[x] = {}
	end
	self.cubepos[x][y] = cube
end

--
--上下左右滑动
--direction
-- 	   1
--  2     4
---    3
--向上是1
--向左是2
--向下是3
--向右是4

--onComplete 结束回调函数

function Board:slip(direction,onComplete)
	-- 先计算能重合的块
	--onComplete() 运动完成后调用
	--整个坐标如下
	--(1,4)(2,4)(3,4)(4,4)
	--(1,3)(2,3)(3,3)(4,3)
	--(1,2)(2,2)(3,2)(4,2)
	--(1,1)(2,1)(3,1)(4,1)
	--
	--循环到的cube的坐标  需要移动的cube的坐标
	local px = 0 --x
	local py = 0 --y
	--合并计算的cube的坐标
	local dx = 0 --x
	local dy = 0 --y
	--内层循环  外层循环无关紧要
	local loopStart = 0     --循环开始
	local loopEnd 	= 0 	--循环结束
	              	    	
	if direction == 1 then 		--上    内层循环y - 1
		step = -1
		loopStart = 4
		loopEnd   = 1
	elseif direction == 2 then  --左    内层循环x + 1
		step = 1
		loopStart = 1
		loopEnd   = 4
	elseif direction == 3 then  --下    内层循环y + 1
		step = 1
		loopStart = 1
		loopEnd   = 4
	elseif direction == 4 then  --右    内层循环x - 1
		step = -1
		loopStart = 4
		loopEnd   = 1
	end
	print("direction"..direction)
	-- print(loopStart)
	-- print(loopEnd)
	-- print(step)
	-- 外层循环
	for i=loopStart,loopEnd,step do
		--内层循环
		for j=loopStart,loopEnd,step do
			if direction == 3 or direction == 1 then --当上下拨动的时候 外层循环是x坐标 i  内层是y坐标
				px = i
				py = j
			else --当左右拨动的时候 外层循环是y坐标 i
				px = j
				py = i
			end
			--
			print((px)..""..(py))
			--按着顺序计算位移 向loopStart 方向开始计算
			--如果是空的，则赋值进去
			--依次计算移动方向的坐标
			--移动后的位置
			local ddx = 0
			local ddy = 0
			for k = j,loopStart,-step do
				if direction == 3 or direction == 1 then
					dx = i
					dy = k
					print((i).."--"..(k))
				else
					dx = k
					dy = i
					print((k).."--"..(i))
				end
				--如果
				if dx == px and dy ==py then 
					print("itself")
				else
					if self.cubepos[dx][dy]==nil then 
						if direction == 3 or direction == 1 then
							self.cubepos[dx][dy] = self.cubepos[dx][dy+step]
							self.cubepos[dx][dy+step] = nil
						else
							self.cubepos[dx][dy] = self.cubepos[dx+step][dy]
							self.cubepos[dx+step][dy] = nil
						end
						ddx = dx
						ddy = dy
						--简单的移动
						--TODO 播放动画
					else
						--判断能不能合并
						 if self.cubepos[dx][dy].value==self.cubepos[px][py].value then 
						 	--能合并  移动完成后 播放合并动画
						 	--TODO 播放动画 动画回调完成 数值*2
						 end
					end
				end
			end
		end
	end
end

return Board