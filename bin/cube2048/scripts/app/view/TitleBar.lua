--[[
	游戏的上半部分 
					 菜单--待定
	标题	分值 
	说明	
]]
local TitleBar = class("TitleBar", function ()
	return display.newLayer()
end)

function TitleBar:ctor()
	--标题 2048 
	--[[
	if self.title == nil then
		self.title = ui.newBMFontLabel({
			text = "2048",
			font = "lcd.fnt"
			})
	end
	]]
	if self.title == nil then
		self.title = ui.newTTFLabel({
			text = "2048",
			font = "myxihei.ttf",
			size = 128,
			color = ccc3(255, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
	end
	self.title:setColor(ccc3(37,37,37))
	self.title:setAnchorPoint(ccp(0,0))
	self:addChild(self.title)

	local f9bg = display.newScale9Sprite("#fbg.png", x, y, cc.size())

	--score label

	--best 

end



return TitleBar