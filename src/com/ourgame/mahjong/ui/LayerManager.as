package com.ourgame.mahjong.ui
{
	import com.wecoit.display.DisplayElement;
	import com.wecoit.errors.SingletonError;
	
	/**
	 * 图层管理器
	 * @author SiaoLeon
	 */
	public class LayerManager
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		private static var _instance:LayerManager;
		
		/**
		 * 获取单例对象
		 */
		public static function get instance():LayerManager
		{
			if (_instance == null)
			{
				_instance = new LayerManager();
			}
			return _instance;
		}
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		private var _tip:DisplayElement;
		
		/**
		 * 提示层
		 * @return
		 */
		public function get tip():DisplayElement
		{
			return this._tip;
		}
		
		private var _pop:DisplayElement;
		
		/**
		 * 弹出层
		 * @return
		 */
		public function get pop():DisplayElement
		{
			return this._pop;
		}
		
		private var _game:GameContainer;
		
		/**
		 * 游戏层
		 * @return
		 */
		public function get game():GameContainer
		{
			return this._game;
		}
		
		private var _foreground:DisplayElement;
		
		/**
		 * 前景层
		 * @return
		 */
		public function get foreground():DisplayElement
		{
			return this._foreground;
		}
		
		private var _background:DisplayElement;
		
		/**
		 * 背景层
		 * @return
		 */
		public function get background():DisplayElement
		{
			return this._background;
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function LayerManager()
		{
			if (_instance != null)
			{
				throw new SingletonError(this);
			}
			_instance = this;
			
			this.init();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function init():void
		{
			this._background = new DisplayElement();
			this._foreground = new DisplayElement();
			this._game = new GameContainer();
			this._pop = new DisplayElement();
			this._tip = new DisplayElement();
		}
	
	}
}
