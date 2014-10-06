package com.ourgame.mahjong.lobby.state
{
	import com.ourgame.mahjong.lobby.controller.LobbyController;
	import com.ourgame.mahjong.lobby.controller.LobbySocketController;
	import com.ourgame.mahjong.room.state.RoomState;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.State;
	
	/**
	 * 大厅状态
	 * @author SiaoLeon
	 */
	public class LobbyState extends State
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
		public function LobbyState(key:Object=null)
		{
			super(key);
			
			this.add(new RoomState());
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onInit():void
		{
		}
		
		override public function onEnter():void
		{
			Log.debug("进入大厅");
			
			this.addController(new LobbySocketController());
			this.addController(new LobbyController());
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
