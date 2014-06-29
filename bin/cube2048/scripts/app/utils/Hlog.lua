--分析工具
local Hlog = {}

-- 发log
function Hlog.log(command,eventid)
	if device.platform == "android" or device.platform == "ios" then
		cc.analytics:doCommand{command = command,
        	            args = {eventId = eventid}}
	end

	print("umeng log:"..command..","..eventid)
end

--发自定义的事件
function Hlog.logevent(eventid)
	if device.platform == "android" or device.platform == "ios" then
		cc.analytics:doCommand{command = "event",
        	            args = {eventId = eventid}}
	end
	print("umeng log:".."event"..","..eventid)
end


return Hlog