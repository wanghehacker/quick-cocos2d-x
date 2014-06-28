
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:onEnterBackground()
	cc.analytics:doCommand{command = "applicationDidEnterBackground"}
end

function MyApp:onEnterForeground()
	cc.analytics:doCommand{command = "applicationWillEnterForeground"}
end


function MyApp:run()

	 -- init analytics
    if device.platform == "android" or device.platform == "ios" then
        cc.analytics:start("analytics.UmengAnalytics")
    end

     -- 改为真实的应用ID，第二参数为渠道号(可选)
    if device.platform == "android" then
    	cc.analytics:doCommand{command = "startWithAppkey",
    			args = {appKey = "53ae92f256240b128d0d2ce6",channelId = "andofficial"}}
    elseif device.platform == "ios" then
    	cc.analytics:doCommand{command = "startWithAppkey",
    			args = {appKey = "53ae92f256240b128d0d2ce6",channelId = "iosofficial"}}
    end

    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    display.addSpriteFramesWithFile(GAME_TEXTURE_DATA_FILENAME,GAME_TEXTURE_IMAGE_FILENAME)

    self:enterScene("MainScene",nil,0.5,display.COLOR_WHITE)
end

return MyApp
