package com.ourgame.mahjong.main.model
{
	import com.netease.protobuf.Message;
	import com.ourgame.mahjong.libaray.SocketProcessor;
	import com.ourgame.mahjong.libaray.data.CommonData;
	import com.ourgame.mahjong.libaray.events.SocketEvent;
	import com.ourgame.mahjong.main.method.SocketMethod;
	import com.wecoit.mvc.Model;
	
	/**
	 * 主程序Socket数据模型
	 * @author SiaoLeon
	 */
	public class MainSocketModel extends Model
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function MainSocketModel()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			CommonData.socket = new SocketProcessor();
			CommonData.socket.addEventListener(SocketEvent.CONNECTED, onConnected);
			CommonData.socket.addEventListener(SocketEvent.ERROR, onError);
			CommonData.socket.addEventListener(SocketEvent.CLOSED, onClosed);
			CommonData.socket.addEventListener(SocketEvent.DISCONNECT, onDisconnect);
			CommonData.socket.addEventListener(SocketEvent.FLUSH, onFlush);
			CommonData.socket.addEventListener(SocketEvent.RECIVE, onRecive);
		}
		
		override public function onRemove():void
		{
			CommonData.socket.removeEventListener(SocketEvent.CONNECTED, onConnected);
			CommonData.socket.removeEventListener(SocketEvent.ERROR, onError);
			CommonData.socket.removeEventListener(SocketEvent.CLOSED, onClosed);
			CommonData.socket.removeEventListener(SocketEvent.DISCONNECT, onDisconnect);
			CommonData.socket.removeEventListener(SocketEvent.FLUSH, onFlush);
			CommonData.socket.removeEventListener(SocketEvent.RECIVE, onRecive);
			CommonData.socket = null;
		}
		
		public function onConnected(event:SocketEvent):void
		{
			this.notify(SocketMethod.CONNECT_SUCCESS(MainSocketModel));
		}
		
		public function onError(event:SocketEvent):void
		{
			this.notify(SocketMethod.CONNECT_ERROR(MainSocketModel));
		}
		
		public function onClosed(event:SocketEvent):void
		{
			this.notify(SocketMethod.CLOSED(MainSocketModel));
		}
		
		public function onDisconnect(event:SocketEvent):void
		{
			this.notify(SocketMethod.DISCONECT(MainSocketModel));
		}
		
		public function onFlush(event:SocketEvent):void
		{
			this.notify(SocketMethod.FLUSH(MainSocketModel), event.data);
		}
		
		public function onRecive(event:SocketEvent):void
		{
			this.notify(SocketMethod.RECIVED(MainSocketModel), event.data);
		}
		
		/**
		 * 建立Socket连接
		 */
		public function connect(host:String, port:uint):void
		{
			if (CommonData.socket.client.connected)
			{
				CommonData.socket.close();
			}
			
			CommonData.socket.connect(host, port);
		}
		
		/**
		 * 发送Socket数据
		 * @param type
		 * @param msg
		 */
		public function send(type:int, msg:Message=null):void
		{
			CommonData.socket.send(type, msg);
		}
		
		/**
		 * 模拟Socket数据
		 * @param type
		 * @param msg
		 */
		public function push(type:int, msg:Message=null):void
		{
			CommonData.socket.push(type, msg);
		}
		
		/**
		 * 关闭Socket连接
		 */
		public function close():void
		{
			CommonData.socket.close();
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
