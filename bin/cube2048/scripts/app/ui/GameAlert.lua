local GameAlert = class(GameAlert, function()
	return display.newLayer()
	end)

--全局存储

function GameAlert:ctor()
	self.bg = display.newScale9Sprite("#alertbg.png",10,10,cc.size(10,10))
	self.bg:setContentSize(cc.size(660,620))
	self:addChild(self.bg)
end


--显示
--content 内容
--按钮们
function GameAlert:show(content,buttons)
	self.content = ui.newTTFLabel({
		text = content,
		size = 60,
		color = ccc3(37, 37, 37)
		})
	self.content:setPosition(ccp(0,100))
	self:addChild(self.content)

	local items = {}
	local beiginx = -100
	if #buttons == 1 then 
		beiginx = 0
	end
	for k,v in pairs(buttons) do
		items[#items+1] = ui.newTTFLabelMenuItem({
			text = v.name,
			font = "myxihei.ttf",
			size = 40,
			color = ccc3(37, 37, 37),
			listener = v.handle,
			x = beiginx,
			y = 0
			})
		beiginx = beiginx + 200
	end

	self.menu = ui.newMenu(items)
	self:addChild(self.menu)
	self.menu:setPosition(ccp(0,-100))
end

return GameAlert