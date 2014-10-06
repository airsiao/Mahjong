package com.ourgame.mahjong.main.model
{
	import com.ourgame.mahjong.libaray.GameLoader;
	import com.ourgame.mahjong.libaray.vo.GameInfo;
	import com.ourgame.mahjong.main.method.MainMethod;
	import com.wecoit.debug.Log;
	import com.wecoit.events.BytesEvent;
	import com.wecoit.mvc.Model;
	
	import flash.events.ProgressEvent;
	
	/**
	 * 游戏加载数据模型
	 * @author SiaoLeon
	 */
	public class GameLoadModel extends Model
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var loader:GameLoader;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function GameLoadModel()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.loader = new GameLoader();
			this.loader.addEventListener(BytesEvent.ERROR, onError, false, 0, true);
			this.loader.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
			this.loader.addEventListener(BytesEvent.COMPLETE, onComplete, false, 0, true);
		}
		
		override public function onRemove():void
		{
			this.loader.removeEventListener(BytesEvent.ERROR, onError);
			this.loader.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			this.loader.removeEventListener(BytesEvent.COMPLETE, onComplete);
			this.loader = null;
		}
		
		public function load(game:GameInfo):void
		{
			Log.debug("加载游戏：", game.name);
			
			this.loader.load(game);
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function onError(event:BytesEvent):void
		{
			this.notify(MainMethod.LOAD_GAME_ERROR, this.loader.info);
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			var pre:Number = this.loader.currentLoaded / this.loader.currentTotal / this.loader.countTotal + this.loader.countLoaded / this.loader.countTotal;
			pre = isNaN(pre) ? this.loader.countLoaded / this.loader.countTotal : pre;
			
			Log.debug("加载进度：", Math.floor(pre * 100), this.loader.countLoaded, this.loader.countTotal);
			
			this.notify(MainMethod.LOAD_GAME_PROGRESS, pre);
		}
		
		private function onComplete(event:BytesEvent):void
		{
			Log.info("加载完成");
			
			this.notify(MainMethod.LOAD_GAME_COMPLETE, this.loader.info);
		}
	
	}
}
