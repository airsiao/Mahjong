package com.ourgame.mahjong.main.state
{
	import com.ourgame.mahjong.lobby.state.LobbyState;
	import com.ourgame.mahjong.main.controller.GameController;
	import com.ourgame.mahjong.main.controller.MainController;
	import com.ourgame.mahjong.main.controller.MainSocketController;
	import com.ourgame.mahjong.main.model.GameLoadModel;
	import com.ourgame.mahjong.main.model.MainSocketModel;
	import com.ourgame.mahjong.main.model.UserModel;
	import com.ourgame.mahjong.main.view.MainView;
	import com.ourgame.mahjong.room.state.RoomState;
	import com.wecoit.mvc.State;
	
	/**
	 * 主程序状态
	 * @author SiaoLeon
	 */
	public class MainState extends State
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		public var view:MainView;
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function MainState(key:Object=null)
		{
			super(key);
			
			this.add(new LobbyState());
			this.add(new RoomState());
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onInit():void
		{
			this.view = new MainView();
		}
		
		override public function onEnter():void
		{
			this.addModel(UserModel);
			this.addModel(MainSocketModel);
			this.addModel(GameLoadModel);
			
			this.addView(this.view);
			
			this.addController(new MainSocketController());
			this.addController(new MainController());
			this.addController(new GameController());
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
