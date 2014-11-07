package com.ourgame.mahjong.view
{
	import com.ourgame.mahjong.ui.LayerManager;
	import com.wecoit.mvc.View;
	
	/**
	 * 图层视图
	 * @author SiaoLeon
	 */
	public class LayerView extends View
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
		public function LayerView()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			LayerManager.instance.game.y = 85;
			
			this.module.addChild(LayerManager.instance.background);
			this.module.addChild(LayerManager.instance.foreground);
			this.module.addChild(LayerManager.instance.game);
			this.module.addChild(LayerManager.instance.pop);
			this.module.addChild(LayerManager.instance.tip);
		}
		
		override public function onRemove():void
		{
			LayerManager.instance.background.clear();
			LayerManager.instance.foreground.clear();
			LayerManager.instance.game.clear();
			LayerManager.instance.pop.clear();
			LayerManager.instance.tip.clear();
			
			this.module.removeChild(LayerManager.instance.background);
			this.module.removeChild(LayerManager.instance.foreground);
			this.module.removeChild(LayerManager.instance.game);
			this.module.removeChild(LayerManager.instance.pop);
			this.module.removeChild(LayerManager.instance.tip);
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
