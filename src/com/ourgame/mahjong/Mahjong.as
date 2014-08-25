package com.ourgame.mahjong
{
	import com.ourgame.mahjong.libaray.DataExchange;
	import com.ourgame.mahjong.libaray.GameLoader;
	import com.ourgame.mahjong.libaray.vo.GameInfo;
	import com.wecoit.data.XmlValue;
	import com.wecoit.debug.Log;
	import com.wecoit.events.BytesEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ProgressEvent;
	
	[SWF(width="960", height="600", backgroundColor="#000000", frameRate="25")]
	
	/**
	 * 麻将启动程序
	 * @author SiaoLeon
	 */
	public class Mahjong extends Sprite
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		public var data:DataExchange;
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var loader:GameLoader;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function Mahjong()
		{
			super();
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			
			this.data = new DataExchange();
			
			this.startup(new XmlValue(<game name="Main">data/assets.xml</game>));
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		public function startup(info:XmlValue):void
		{
			this.loader = new GameLoader();
			this.loader.addEventListener(BytesEvent.ERROR, onError, false, 0, true);
			this.loader.addEventListener(ProgressEvent.PROGRESS, onProgress, false, 0, true);
			this.loader.addEventListener(BytesEvent.COMPLETE, onComplete, false, 0, true);
			this.loader.load(new GameInfo(info, this.data));
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function onError(event:BytesEvent):void
		{
			this.loader = null;
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			var pre:Number = this.loader.currentLoaded / this.loader.currentTotal / this.loader.countTotal + this.loader.countLoaded / this.loader.countTotal;
			pre = isNaN(pre) ? this.loader.countLoaded / this.loader.countTotal : pre;
			
			Log.debug("加载进度：", Math.floor(pre * 100), this.loader.countLoaded, this.loader.countTotal);
		}
		
		private function onComplete(event:BytesEvent):void
		{
			Log.info("加载完成");
			
			var game:GameInfo = this.loader.info;
			this.loader = null;
			
			if (game.main.hasOwnProperty("info"))
			{
				game.main["info"] = game;
			}
			
			this.stage.addChild(game.main);
			this.stage.removeChild(this);
		}
	
	}
}
