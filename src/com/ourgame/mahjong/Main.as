package com.ourgame.mahjong
{
	import com.ourgame.mahjong.libaray.vo.GameInfo;
	import com.ourgame.mahjong.main.state.MainState;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.data.HashMap;
	import com.wecoit.mvc.Application;
	import com.wecoit.mvc.core.IState;
	
	[SWF(width="960", height="600", backgroundColor="#000000", frameRate="25")]
	
	/**
	 * 麻将主程序
	 * @author SiaoLeon
	 */
	public class Main extends Application
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		/**
		 * 信息
		 */
		private var _info:GameInfo;
		
		public function get info():GameInfo
		{
			return this._info;
		}
		
		public function set info(value:GameInfo):void
		{
			this._info = value;
			
			var assets:HashMap = this.info.assets;
			
			for each (var key:* in assets.keys)
			{
				AssetsManager.instance.saveAsset(key, assets.getValue(key));
			}
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function Main(root:IState=null)
		{
			super(new MainState());
		}
	
		// -------------------------------------------------------------------------------------------------------- 方法
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
