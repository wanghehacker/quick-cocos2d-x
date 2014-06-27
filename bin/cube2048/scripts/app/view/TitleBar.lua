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
			size = 110,
			color = ccc3(255, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
	end
	self.title:setColor(ccc3(37,37,37))
	self.title:setAnchorPoint(ccp(0,0))
	self:addChild(self.title)

	--当前分数的背景
	local f9bg = display.newScale9Sprite("#fbg.png", 26, 26, cc.size(45,30))
	f9bg:setContentSize(cc.size(140,100))
	f9bg:setPosition(ccp(330,70))
	self:addChild(f9bg)

	--总分的背景
	local f9bg2 = display.newScale9Sprite("#fbg.png", 26, 26, cc.size(45,30))
	f9bg2:setContentSize(cc.size(140,100))
	f9bg2:setPosition(ccp(330+150,70))
	self:addChild(f9bg2)


	--score label
	if self.scoretitle == nil then
		self.scoretitle = ui.newTTFLabel({
			text = "score",
			font = "myxihei.ttf",
			size = 30,
			color = ccc3(255, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
	end
	self.scoretitle:setColor(ccc3(37,37,37))
	self.scoretitle:setPosition(ccp(330,92))
	self:addChild(self.scoretitle)

	if self.score == nil then
		self.score = ui.newTTFLabel({
			text = "0",
			font = "myxihei.ttf",
			size = 30,
			color = ccc3(255, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
	end
	self.score:setColor(ccc3(37,37,37))
	self.score:setPosition(ccp(330,48))
	self:addChild(self.score)

	--best 
	if self.besttitle == nil then
		self.besttitle = ui.newTTFLabel({
			text = "best",
			font = "myxihei.ttf",
			size = 30,
			color = ccc3(255, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
	end
	self.besttitle:setColor(ccc3(37,37,37))
	self.besttitle:setPosition(ccp(480,92))
	self:addChild(self.besttitle)

	if self.best == nil then
		self.best = ui.newTTFLabel({
			text = "0",
			font = "myxihei.ttf",
			size = 30,
			color = ccc3(255, 255, 255),
			align = ui.TEXT_ALIGN_CENTER,
			valign = ui.TEXT_ALIGN_CENTER,
			})
	end
	self.best:setColor(ccc3(37,37,37))
	self.best:setPosition(ccp(480,48))
	self:addChild(self.best)
end

--设置分数
function TitleBar:setScore(score)
	self.score:setString(tostring(score))
end

--设置最好成绩
function TitleBar:setBestScore(score)
	self.best:setString(tostring(score))
end



return TitleBar