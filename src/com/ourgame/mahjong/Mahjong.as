package com.ourgame.mahjong
{
	import com.ourgame.mahjong.data.CoreData;
	import com.ourgame.mahjong.state.MainState;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.debug.Log;
	import com.wecoit.events.BytesEvent;
	import com.wecoit.loader.BytesLoader;
	import com.wecoit.mvc.Application;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	import flash.ui.Keyboard;
	
	[SWF(width="960", height="685", backgroundColor="#000000", frameRate="24")]
	
	/**
	 * 麻将启动程序
	 * @author SiaoLeon
	 */
	public class Mahjong extends Application
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var loader:BytesLoader;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function Mahjong()
		{
			Security.allowDomain("*");
			
			this.loader = new BytesLoader();
			this.loader.addEventListener(BytesEvent.ERROR, onError);
			this.loader.addEventListener(BytesEvent.COMPLETE, onComplete);
			this.loader.load(CoreData.UI);
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		override protected function onAddedToStage():void
		{
			super.onAddedToStage();
			
			Application.stage.scaleMode = StageScaleMode.NO_SCALE;
			Application.stage.align = StageAlign.TOP_LEFT;
			
			Log.instance.listen(this.stage, Keyboard.END, true, true);
		}
		
		private function onError(event:BytesEvent):void
		{
			Log.error("加载资源错误", this.loader.url);
			
			this.loader.removeEventListener(BytesEvent.ERROR, onError);
			this.loader.removeEventListener(BytesEvent.COMPLETE, onComplete);
			this.loader = null;
		}
		
		private function onComplete(event:BytesEvent):void
		{
			Log.error("加载资源完成");
			
			AssetsManager.instance.saveAsset("UI", this.loader.content);
			
			this.loader.removeEventListener(BytesEvent.ERROR, onError);
			this.loader.removeEventListener(BytesEvent.COMPLETE, onComplete);
			this.loader = null;
			
			this.rootState = new MainState();
		}
	
	}
}
