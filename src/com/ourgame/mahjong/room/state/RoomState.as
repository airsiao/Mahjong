package com.ourgame.mahjong.room.state
{
	import com.ourgame.mahjong.room.controller.RoomController;
	import com.ourgame.mahjong.room.controller.RoomSocketController;
	import com.ourgame.mahjong.table.state.TableState;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.State;
	
	/**
	 * 房间状态
	 * @author SiaoLeon
	 */
	public class RoomState extends State
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
		public function RoomState(key:Object=null)
		{
			super(key);
			
			this.add(new RoomAutoState());
			this.add(new RoomManualState());
			
			this.add(new TableState());
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onEnter():void
		{
			Log.info("进入房间状态");
			
			this.addController(new RoomSocketController());
			this.addController(new RoomController());
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
