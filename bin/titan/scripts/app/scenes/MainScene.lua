cc.util 		= require("framework.cc.utils.init")
cc.net 	 		= require("framework.cc.net.init")

local PacketBuffer = require("net.PacketHelper")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	printInfo("socket.getTime:%f", cc.net.SocketTCP.getTime())
	printInfo("os.gettime:%f",os.time())
	printInfo("socket._VERSION:%s",cc.net.SocketTCP._VERSION)

	local  __luaSocketLabel = ui.newTTFLabelMenuItem({
		text="lua socket connect",
		size = 32,
		x = display.cx,
		y = display.top - 64,
		listener = handler(self, self.onLuaSocketConnectClicked),
		})

	local __luaSocketSendLabel = ui.newTTFLabelMenuItem({
		text = "lua socket sen fuck",
		size = 32,
		x = display.cx,
		y = display.top - 128,
		listener = handler(self,self.onSocketSend)
		})

	self:addChild(ui.newMenu({__luaSocketLabel,__luaSocketSendLabel}))
end

function MainScene:onLuaSocketConnectClicked()
	if not self._socket then
		self._socket = cc.net.SocketTCP.new("127.0.0.1",8777,false)
		-- 监听各种事件
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CONNECTED, hanlder(self,self.onStatus))
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CLOSE, hanlder(self,self.onStatus))
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CLOSED, hanlder(self,self.onStatus))
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CONNECT_FAILURE, hanlder(self,self.onStatus))
		-- 数据接收
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_DATA, hanlder(self,self.onData))
	end
end

function MainScene:onSocketSend()

end


function MainScene:onStatus(__event)
	printInfo("socket status:%s",__event.name)
	dump(__event)
end


function MainScene:onData(__event)
	print("socket receive raw data:",cc.utils.ByteArray.tostring(__event.data,16))
	local __msgs = self._buf:parsePackets(__event.data)
	local __msg = nil
	for i=1,#__msgs do
		__msg = __msgs[i]
		dump(__msg)
	end
end


function MainScene:onEnter()
    print("hello")
end

function MainScene:onExit()
    
end

return MainScene
