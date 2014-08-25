package com.ourgame.mahjong.main.model
{
	import com.netease.protobuf.Message;
	import com.ourgame.mahjong.Main;
	import com.ourgame.mahjong.libaray.SocketProcessor;
	import com.ourgame.mahjong.libaray.events.SocketEvent;
	import com.ourgame.mahjong.main.method.SocketMethod;
	import com.wecoit.mvc.Model;
	import com.wecoit.mvc.State;
	
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
		
		private var socket:SocketProcessor;
		
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
			this.socket = ((this.context as State).manager as Main).info.data.socket;
			
			this.socket.addEventListener(SocketEvent.CONNECTED, onConnected);
			this.socket.addEventListener(SocketEvent.ERROR, onError);
			this.socket.addEventListener(SocketEvent.CLOSED, onClosed);
			this.socket.addEventListener(SocketEvent.DISCONNECT, onDisconnect);
			this.socket.addEventListener(SocketEvent.FLUSH, onFlush);
			this.socket.addEventListener(SocketEvent.RECIVE, onRecive);
		}
		
		override public function onRemove():void
		{
			this.socket.removeEventListener(SocketEvent.CONNECTED, onConnected);
			this.socket.removeEventListener(SocketEvent.ERROR, onError);
			this.socket.removeEventListener(SocketEvent.CLOSED, onClosed);
			this.socket.removeEventListener(SocketEvent.DISCONNECT, onDisconnect);
			this.socket.removeEventListener(SocketEvent.FLUSH, onFlush);
			this.socket.removeEventListener(SocketEvent.RECIVE, onRecive);
			
			this.socket = null;
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
			if (this.socket.client.connected)
			{
				this.socket.close();
			}
			
			this.socket.connect(host, port);
		}
		
		/**
		 * 发送Socket数据
		 * @param type
		 * @param msg
		 */
		public function send(type:int, msg:Message=null):void
		{
			this.socket.send(type, msg);
		}
		
		/**
		 * 模拟Socket数据
		 * @param type
		 * @param msg
		 */
		public function push(type:int, msg:Message=null):void
		{
			this.socket.push(type, msg);
		}
		
		/**
		 * 关闭Socket连接
		 */
		public function close():void
		{
			this.socket.close();
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
