package com.ourgame.mahjong.lobby.view
{
	import com.ourgame.mahjong.lobby.enum.UIDefinition;
	import com.ourgame.mahjong.main.ui.LayerManager;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.mvc.View;
	
	import flash.display.MovieClip;
	
	/**
	 * 排行榜视图
	 * @author SiaoLeon
	 */
	public class RankView extends View
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var background:MovieClip;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function RankView()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.background = AssetsManager.instance.getDefinitionMovieClip(UIDefinition.RankBackground);
			this.background.gotoAndStop(1);
			this.background.x = 700;
			this.background.y = 116;
			LayerManager.instance.foreground.addChild(this.background);
		}
		
		override public function onRemove():void
		{
			LayerManager.instance.foreground.removeChild(this.background);
			this.background = null;
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
