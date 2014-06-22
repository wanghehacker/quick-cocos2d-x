--[[
	网络发送
]]

--require("config")
PacketHelper.ENDIAN = cc.utils.ByteArrayVarint.ENDIAN_BIG

PacketHelper.MASK1 = 0x86
PacketHelper.MASK2 = 0x7b
PacketHelper.RANDOM_MAX = 10000
PacketHelper.PACKET_MAX_LEN = 2100000000

PacketHelper.FLAG_LEN = 2	-- package flag at start, 1byte per flag
PacketHelper.TYPE_LEN = 1	-- type of message, 1byte
PacketHelper.BODY_LEN = 4	-- length of message body, int
PacketHelper.METHOD_LEN = 2	-- length of message method code, short
PacketHelper.VER_LEN = 1	-- version of message, byte

local PacketHelper = class("PacketHelper",import("cc.utils.ByteArray"))

--默认构造函数
function ByteArrayVarint:ctor()

end

--获取byte流操作对象
--function PacketHelper.getBaseBF()
--	return cc.utils.ByteArray.new(PacketHelper.ENDIAN)
--end


--发送socketa包
--_PacketNumber	int 		协议号 
--_Data 		ByteArray 	二进制数据  
function PacketHelper:send(_PacketNumber,_Data)
	local __head = PacketHelper.getBaseBF()
	--写入协议号
	__head:writeInt(_PacketNumber)
	--写入数据
	__head:writeInt(_Data:getLen())
	--发送到服务器

	if not self._socket then
		--在这初始化的 _socket
		self._socket = cc.net.SocketTCP.new(SERVER_IP, SERVER_PORT, false)
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


return PacketHelper

