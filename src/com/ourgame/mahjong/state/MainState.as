package com.ourgame.mahjong.state
{
	import com.ourgame.mahjong.controller.CommonController;
	import com.ourgame.mahjong.controller.GameController;
	import com.ourgame.mahjong.controller.StartupController;
	import com.ourgame.mahjong.model.ConfigModel;
	import com.ourgame.mahjong.model.GameModel;
	import com.ourgame.mahjong.model.ProxyModel;
	import com.ourgame.mahjong.model.UserModel;
	import com.ourgame.mahjong.view.CommonView;
	import com.ourgame.mahjong.view.GameView;
	import com.ourgame.mahjong.view.LayerView;
	import com.ourgame.mahjong.view.SelectorView;
	import com.wecoit.mvc.State;
	
	/**
	 * 主状态
	 * @author SiaoLeon
	 */
	public class MainState extends State
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		public var layer:LayerView;
		
		public var common:CommonView;
		
		public var selector:SelectorView;
		
		public var game:GameView;
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function MainState(key:Object=null)
		{
			super(key);
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onInit():void
		{
			this.layer = new LayerView();
			this.common = new CommonView();
			this.selector = new SelectorView();
			this.game = new GameView();
		}
		
		override public function onEnter():void
		{
			this.addModel(ConfigModel);
			this.addModel(UserModel);
			this.addModel(GameModel);
			this.addModel(ProxyModel);
			
			this.addView(this.layer);
			this.addView(this.common);
			this.addView(this.selector);
			this.addView(this.game);
			
			this.addController(new StartupController());
			this.addController(new CommonController());
			this.addController(new GameController());
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
