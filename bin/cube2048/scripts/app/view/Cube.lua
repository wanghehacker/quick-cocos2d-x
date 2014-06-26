
local TypeData = import("..data.TypeData")

local Cube = class("Cube", function(value)
	local pic = nil
	--获取当前的背景色
	for k,v in ipairs(TypeData) do
		if v.value == value then
			pic = v.bg
			break
		end
	end
	local sprite = display.newSprite("#"..pic)
	return sprite
end)


function Cube:ctor(value)
	-- 保存值
	self.value = value

	if self.label == nil then
		local label = ui.newTTFLabel({
			text = tostring(value),
			font = "Arial",
			size = 64,
			color = ccc3(255, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
		self.label = label
	end
	self:addChild(self.label)
	self.label:setPosition(55,55)
end

function Cube:setValue(value,onComplete)
	if self.label == nil then
		local label = ui.newTTFLabel({
			text = tostring(value),
			font = "Arial",
			size = 32,
			color = ccc3(0, 0, 0),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
		self.label = label
	end
	self:addChild(self.label)
end


--改变值和底图
function Cube:changeValue(newValue,onComplete)
	--保存值
	self.value = newValue
	--换图
	local pic = nil
	--获取当前的背景色
	for k,v in ipairs(TypeData) do
		if v.value == newValue then
			pic = v.bg
			break
		end
	end
	--
	print("newvalue "..newValue)
	local frameNo = display.newSpriteFrame(pic)
	self:setDisplayFrame(frameNo)

	--改变label的值
	self.label:setString(tostring(newValue))
end

return Cube