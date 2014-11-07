package com.ourgame.mahjong.vo
{
	import com.wecoit.data.ValueObject;
	import com.wecoit.data.XmlValue;
	
	import flash.display.DisplayObject;
	
	/**
	 * 游戏信息
	 * @author SiaoLeon
	 */
	public class GameInfo extends ValueObject
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		/**
		 * ID
		 * @return
		 */
		public function get id():uint
		{
			return this.getProperty("id", 0);
		}
		
		/**
		 * 名称
		 * @return
		 */
		public function get name():String
		{
			return this.getProperty("name", "");
		}
		
		/**
		 * 排序
		 * @return
		 */
		public function get order():uint
		{
			return this.getProperty("order", 0);
		}
		
		/**
		 * 路径
		 * @return
		 */
		public function get path():String
		{
			return this.getProperty("path", "");
		}
		
		/**
		 * 地址
		 * @return
		 */
		public function get url():String
		{
			return this.getProperty("url", "");
		}
		
		/**
		 * 主程序
		 * @return
		 */
		public function get main():DisplayObject
		{
			return this.getProperty("main", null);
		}
		
		public function set main(value:DisplayObject):void
		{
			this.setProperty("main", value);
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function GameInfo(info:XmlValue)
		{
			super();
			
			this.setProperty("id", info.attribute("id"));
			this.setProperty("name", info.name);
			this.setProperty("order", info.attribute("order"));
			this.setProperty("path", info.attribute("path"));
			this.setProperty("url", info.value);
		}
	
		// -------------------------------------------------------------------------------------------------------- 方法
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
