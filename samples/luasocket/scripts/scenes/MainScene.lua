cc.utils 				= require("framework.cc.utils.init")
cc.net 					= require("framework.cc.net.init")

local PacketBuffer = require("net.PacketBuffer")
local Protocol = require("net.Protocol")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	printInfo("socket.getTime:%f", cc.net.SocketTCP.getTime())
	printInfo("os.gettime:%f", os.time())
	printInfo("socket._VERSION: %s", cc.net.SocketTCP._VERSION)

	local __luaSocketLabel = ui.newTTFLabelMenuItem({
		text = "lua socket connect",
		size = 32,
		x = display.cx,
		y = display.top - 32,
		listener = handler(self, self.onLuaSocketConnectClicked),
	})

	local __luaSocket1000Label = ui.newTTFLabelMenuItem({
		text = "lua socket send 1000",	
		size = 32,
		x = display.cx,
		y = display.top - 64,
		listener = handler(self, function() self:send2Socket(1000, {8000, 1,1}) end)
	})

    self:addChild(ui.newMenu({__luaSocketLabel, __luaSocket1000Label}))

	self._buf = PacketBuffer.new()
end

function MainScene:onStatus(__event)
	printInfo("socket status: %s", __event.name)
end

--__method 	协议号
--__msg 	数据
function MainScene:send2Socket(__method, __msg)
	if not self._socket then
		print("connect first")
		return
	end

	--local __def = Protocol.getSend(__method)
	--local __buf = PacketBuffer.createPacket(__def, __msg)
	
	local __bhead = cc.utils.ByteArray.new(cc.utils.ByteArray.ENDIAN_BIG)
	local __bbody = cc.utils.ByteArray.new(cc.utils.ByteArray.ENDIAN_BIG)
	__bbody:writeShort(60000)
	printf("send packets ba: %s", __bbody:toString(16)2)
	printf("send packets ba len: %s", __bbody:getLen())
	__bhead:writeInt(__bbody:getLen())
	printf("_baa len %s",__bhead:getLen())
	printf("send packet baa: %s", __bhead:toString(16))
	__bhead:writeBytes(__bbody)
	printf("length:%s",__bbody:getLen())
	printf("lengtha:%s",__bhead:getLen())
	printf("send packet: %s", __bhead:toString(16))
	__bhead:setPos(1)
	self._socket:send(__bhead:getPack())
end

function MainScene:onData(__event)
	print("socket receive raw data:", cc.utils.ByteArray.toString(__event.data, 16))
	local __msgs = self._buf:parsePackets(__event.data)
	local __msg = nil
	for i=1,#__msgs do
		__msg = __msgs[i]
		dump(__msg)
	end
end

function MainScene:onLuaSocketConnectClicked()
	if not self._socket then
		--在这初始化的 _socket
		self._socket = cc.net.SocketTCP.new("127.0.0.1", 8777, false)
		--连接
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CONNECTED, handler(self, self.onStatus))
		--关闭连接
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CLOSE, handler(self,self.onStatus))
		--关闭连接  完成
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CLOSED, handler(self,self.onStatus))
		--连接失败
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_CONNECT_FAILURE, handler(self,self.onStatus))
		--传输数据
		self._socket:addEventListener(cc.net.SocketTCP.EVENT_DATA, handler(self,self.onData))
	end
	self._socket:connect()
end

return MainScene
