package com.ourgame.mahjong.controller
{
	import com.ourgame.mahjong.method.MainMethod;
	import com.ourgame.mahjong.model.GameModel;
	import com.ourgame.mahjong.state.MainState;
	import com.ourgame.mahjong.vo.GameInfo;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	
	/**
	 * 游戏控制器
	 * @author SiaoLeon
	 */
	public class GameController extends Controller
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
		public function GameController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(MainMethod.ENTER_GAME, ENTER_GAME);
			this.register(MainMethod.LOAD_GAME_ERROR, LOAD_GAME_ERROR);
			this.register(MainMethod.LOAD_GAME_COMPLETE, LOAD_GAME_COMPLETE);
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function ENTER_GAME(notice:INotice):void
		{
			var game:GameInfo = notice.params;
			
			Log.debug("进入游戏：", game.name);
			
			(this.context.getModel(GameModel) as GameModel).load(game);
		}
		
		private function LOAD_GAME_ERROR(notice:INotice):void
		{
		
		}
		
		private function LOAD_GAME_COMPLETE(notice:INotice):void
		{
			var game:GameInfo = (this.context.getModel(GameModel) as GameModel).current;
			
			(this.context as MainState).game.play(game);
		}
	
	}
}
