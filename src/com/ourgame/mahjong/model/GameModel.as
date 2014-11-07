package com.ourgame.mahjong.model
{
	import com.ourgame.mahjong.method.MainMethod;
	import com.ourgame.mahjong.vo.GameInfo;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.data.Config;
	import com.wecoit.data.XmlValue;
	import com.wecoit.mvc.Model;
	import com.wecoit.utils.string.stampUrl;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * 游戏数据模型
	 * @author SiaoLeon
	 */
	public class GameModel extends Model
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		private var _current:GameInfo;
		
		public function get current():GameInfo
		{
			return this._current;
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var loader:Loader;
		
		private var games:Vector.<GameInfo>;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function GameModel()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.games = new Vector.<GameInfo>();
			
			this.loader = new Loader();
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
		}
		
		override public function onRemove():void
		{
			this.games = null;
			
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			this.loader = null;
		}
		
		/**
		 * 初始化
		 */
		public function init():void
		{
			var config:Config = AssetsManager.instance.getConfig("games");
			
			for each (var info:XmlValue in config.getOptions())
			{
				this.games.push(new GameInfo(info));
			}
			
			this.games.sort(this.compareGameByOrder);
		}
		
		/**
		 * 加载游戏数据
		 */
		public function load(game:GameInfo):void
		{
			this._current = game;
			
			if (this.current.main == null)
			{
				this.loader.load(new URLRequest(stampUrl(this.current.path + this.current.url)), new LoaderContext(false, new ApplicationDomain()));
			}
			else
			{
				this.notify(MainMethod.LOAD_GAME_COMPLETE);
			}
		}
		
		/**
		 * 根据ID获取游戏信息
		 * @param id
		 * @return
		 */
		public function getGameByID(id:uint):GameInfo
		{
			for each (var game:GameInfo in this.games)
			{
				if (game.id == id)
				{
					return game;
				}
			}
			
			return null;
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function onLoadError(event:Event):void
		{
			this.notify(MainMethod.LOAD_GAME_ERROR);
		}
		
		private function onLoadComplete(event:Event):void
		{
			this.current.main = this.loader.content;
			
			this.notify(MainMethod.LOAD_GAME_COMPLETE);
		}
		
		private function compareGameByOrder(g1:GameInfo, g2:GameInfo):Number
		{
			return g1.order - g2.order;
		}
	
	}
}
