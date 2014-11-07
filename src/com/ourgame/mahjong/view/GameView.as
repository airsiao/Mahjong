package com.ourgame.mahjong.view
{
	import com.ourgame.mahjong.model.ProxyModel;
	import com.ourgame.mahjong.ui.LayerManager;
	import com.ourgame.mahjong.vo.GameInfo;
	import com.wecoit.core.FlashPlayer;
	import com.wecoit.mvc.View;
	
	/**
	 * 游戏视图
	 * @author SiaoLeon
	 */
	public class GameView extends View
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
		public function GameView()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			LayerManager.instance.game.proxy = this.context.getModel(ProxyModel) as ProxyModel;
		}
		
		override public function onRemove():void
		{
			LayerManager.instance.game.proxy = null;
		}
		
		public function play(game:GameInfo):void
		{
			LayerManager.instance.game.clear();
			
			LayerManager.instance.game.addChild(game.main);
			
			FlashPlayer.GC();
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
