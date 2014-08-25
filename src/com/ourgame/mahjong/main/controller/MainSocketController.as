package com.ourgame.mahjong.main.controller
{
	import com.ourgame.mahjong.libaray.vo.socket.MJDataPack;
	import com.ourgame.mahjong.main.method.SocketMethod;
	import com.ourgame.mahjong.main.model.MainSocketModel;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.core.FlashPlayer;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * 主程序Socket控制器
	 * @author SiaoLeon
	 */
	public class MainSocketController extends Controller
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var socket:MainSocketModel;
		
		private var heartBeatTimer:Timer;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function MainSocketController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(SocketMethod.CONNECT(MainSocketModel), CONNECT);
			this.register(SocketMethod.CONNECT_SUCCESS(MainSocketModel), CONNECT_SUCCESS);
			this.register(SocketMethod.CLOSE(MainSocketModel), CLOSE);
			this.register(SocketMethod.CLOSED(MainSocketModel), CLOSED);
			
			this.register(SocketMethod.SEND(MainSocketModel), SEND);
			this.register(SocketMethod.PUSH(MainSocketModel), PUSH);
			this.register(SocketMethod.RECIVED(MainSocketModel), RECIVED);
			
			this.socket = this.context.getModel(MainSocketModel) as MainSocketModel;
			
			this.heartBeatTimer = new Timer(30000);
			this.heartBeatTimer.addEventListener(TimerEvent.TIMER, heartBeat, false, 0, true);
		}
		
		override public function onRemove():void
		{
			this.heartBeatTimer.removeEventListener(TimerEvent.TIMER, heartBeat);
			this.heartBeatTimer.stop();
			this.heartBeatTimer = null;
			
			this.socket = null;
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function CONNECT(notice:INotice):void
		{
			var config:String = (FlashPlayer.isDebug) ? "debug" : "services";
			var host:String = AssetsManager.instance.getConfig(config).getString("ServerHost");
			var port:uint = AssetsManager.instance.getConfig(config).getNumber("ServerPort");
			
			this.socket.connect(host, port);
		}
		
		private function CONNECT_SUCCESS(notice:INotice):void
		{
			this.heartBeatTimer.reset();
			this.heartBeatTimer.start();
		}
		
		private function CLOSE(notice:INotice):void
		{
			this.socket.close();
		}
		
		private function CLOSED(notice:INotice):void
		{
			this.heartBeatTimer.stop();
			this.heartBeatTimer.reset();
		}
		
		private function SEND(notice:INotice):void
		{
			if (notice.params is MJDataPack)
			{
				this.socket.send(notice.params);
			}
		}
		
		private function PUSH(notice:INotice):void
		{
			if (notice.params is MJDataPack)
			{
				this.socket.push(notice.params);
			}
		}
		
		private function RECIVED(notice:INotice):void
		{
			var data:MJDataPack = notice.params;
			
			switch (data.type)
			{
			}
		}
		
		private function heartBeat(event:TimerEvent):void
		{
			Log.debug("发送心跳请求");
		}
	
	}
}
