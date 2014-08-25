package com.ourgame.mahjong.main.controller
{
	import com.ourgame.mahjong.Main;
	import com.ourgame.mahjong.libaray.vo.GameInfo;
	import com.ourgame.mahjong.main.method.MainMethod;
	import com.ourgame.mahjong.main.model.GameLoadModel;
	import com.ourgame.mahjong.table.state.TableState;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.data.XmlValue;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.State;
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
		
		private var current:GameInfo;
		
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
			this.register(MainMethod.LOAD_GAME, LOAD_GAME);
			this.register(MainMethod.LOAD_GAME_ERROR, LOAD_GAME_ERROR);
			this.register(MainMethod.LOAD_GAME_COMPLETE, LOAD_GAME_COMPLETE);
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function LOAD_GAME(notice:INotice):void
		{
			var gameID:uint = notice.params;
			
			if (current == null || current.id != gameID)
			{
				var gameList:Vector.<XmlValue> = AssetsManager.instance.getConfig("Games").getOptions("id", gameID);
				
				if (gameList.length > 0)
				{
					(this.context.getModel(GameLoadModel) as GameLoadModel).load(new GameInfo(gameList[0], ((this.context as State).manager as Main).info.data));
				}
				else
				{
					this.notify(MainMethod.LOAD_GAME_ERROR);
				}
			}
			else
			{
				this.play(current);
			}
		}
		
		private function LOAD_GAME_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function LOAD_GAME_COMPLETE(notice:INotice):void
		{
			this.current = notice.params;
			
			if (this.current.main.hasOwnProperty("info"))
			{
				this.current.main["info"] = this.current;
			}
			
			this.play(this.current);
		}
		
		private function play(game:GameInfo):void
		{
			(this.context as State).manager.switchState(TableState);
			((this.context as State).manager as Main).addChild(game.main);
		}
	
	}
}
