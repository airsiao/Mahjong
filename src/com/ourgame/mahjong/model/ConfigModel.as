package com.ourgame.mahjong.model
{
	import com.ourgame.mahjong.data.CoreData;
	import com.ourgame.mahjong.method.MainMethod;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.data.Config;
	import com.wecoit.events.BytesEvent;
	import com.wecoit.loader.BytesQueueLoader;
	import com.wecoit.mvc.Model;
	import com.wecoit.utils.string.stampUrl;
	
	/**
	 * 服务数接口据模型
	 * @author SiaoLeon
	 */
	public class ConfigModel extends Model
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var loader:BytesQueueLoader;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function ConfigModel()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.loader = new BytesQueueLoader();
			this.loader.addEventListener(BytesEvent.ERROR, onLoadError);
			this.loader.addEventListener(BytesEvent.COMPLETE, onLoadComplete);
		}
		
		override public function onRemove():void
		{
			this.loader.removeEventListener(BytesEvent.ERROR, onLoadError);
			this.loader.removeEventListener(BytesEvent.COMPLETE, onLoadComplete);
			this.loader = null;
		}
		
		/**
		 * 加载游戏数据
		 */
		public function load():void
		{
			this.loader.load(stampUrl(CoreData.CONFIG));
			this.loader.load(stampUrl(CoreData.GAMES));
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function onLoadError(event:BytesEvent):void
		{
			this.notify(MainMethod.LOAD_CONFIG_ERROR);
		}
		
		private function onLoadComplete(event:BytesEvent):void
		{
			var config:Config = new Config(this.loader.content);
			AssetsManager.instance.saveAsset(config.name, config);
			
			if (this.loader.length <= 0)
			{
				this.notify(MainMethod.LOAD_CONFIG_COMPLETE);
			}
		}
	
	}
}
