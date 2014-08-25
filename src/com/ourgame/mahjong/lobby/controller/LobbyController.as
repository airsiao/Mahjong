package com.ourgame.mahjong.lobby.controller
{
	import com.ourgame.mahjong.lobby.method.LobbyMethod;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	
	/**
	 * 大厅控制器
	 * @author SiaoLeon
	 */
	public class LobbyController extends Controller
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
		public function LobbyController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(LobbyMethod.LOGIN_ERROR, LOGIN_ERROR);
			this.register(LobbyMethod.LOGIN_SUCCESS, LOGIN_SUCCESS);
			this.register(LobbyMethod.LOGOUT_ERROR, LOGOUT_ERROR);
			this.register(LobbyMethod.LOGOUT_SUCCESS, LOGOUT_SUCCESS);
			
			this.register(RoomMethod.ROOM_LIST_ERROR, ROOM_LIST_ERROR);
			this.register(RoomMethod.ROOM_LIST_SUCCESS, ROOM_LIST_SUCCESS);
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function LOGIN_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function LOGIN_SUCCESS(notice:INotice):void
		{
			// TODO Auto Generated method stub
			
			this.notify(RoomMethod.ROOM_LIST);
		}
		
		private function LOGOUT_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function LOGOUT_SUCCESS(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ROOM_LIST_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ROOM_LIST_SUCCESS(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
	
	}
}
