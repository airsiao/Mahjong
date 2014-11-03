package com.ourgame.mahjong.table.controller
{
	import com.ourgame.mahjong.libaray.data.CommonData;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.ourgame.mahjong.table.method.TableMethod;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	
	/**
	 * 桌子控制器
	 * @author SiaoLeon
	 */
	public class TableController extends Controller
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
		public function TableController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(TableMethod.GAME_INVITE, GAME_INVITE);
			
			this.notify(RoomMethod.STAND_BY);
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function GAME_INVITE(notice:INotice):void
		{
			CommonData.gameProxy.start();
		}
	
	}
}
