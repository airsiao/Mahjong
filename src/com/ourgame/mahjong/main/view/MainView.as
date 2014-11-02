package com.ourgame.mahjong.main.view
{
	import com.ourgame.mahjong.libaray.vo.GameInfo;
	import com.ourgame.mahjong.main.data.CoreData;
	import com.ourgame.mahjong.main.ui.LayerManager;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.View;
	
	import flash.events.ContextMenuEvent;
	import flash.events.KeyboardEvent;
	import flash.system.System;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	
	/**
	 * 主程序视图
	 * @author SiaoLeon
	 */
	public class MainView extends View
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var version:ContextMenuItem;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function MainView()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.version = new ContextMenuItem("VER：" + CoreData.VERSION);
			this.version.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onVersionSelect);
			
			this.module.contextMenu = new ContextMenu();
			this.module.contextMenu.hideBuiltInItems();
			this.module.contextMenu.customItems.push(this.version);
			
			this.module.addChild(LayerManager.instance.background);
			this.module.addChild(LayerManager.instance.foreground);
			this.module.addChild(LayerManager.instance.game);
			this.module.addChild(LayerManager.instance.pop);
			this.module.addChild(LayerManager.instance.tip);
			
			this.module.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		override public function onRemove():void
		{
			this.version.removeEventListener(ContextMenuEvent.MENU_ITEM_SELECT, onVersionSelect);
			this.version = null;
			
			this.module.removeChild(LayerManager.instance.background);
			this.module.removeChild(LayerManager.instance.foreground);
			this.module.removeChild(LayerManager.instance.game);
			this.module.removeChild(LayerManager.instance.pop);
			this.module.removeChild(LayerManager.instance.tip);
			
			this.module.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		public function play(game:GameInfo):void
		{
			LayerManager.instance.game.addChild(game.main);
		}
		
		public function stop():void
		{
			LayerManager.instance.game.clear();
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function onVersionSelect(event:ContextMenuEvent):void
		{
			System.setClipboard(CoreData.VERSION);
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.END)
			{
				Log.export();
			}
		}
	
	}
}
