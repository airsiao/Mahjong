package com.ourgame.mahjong.data
{
	
	/**
	 * 核心数据
	 * @author SiaoLeon
	 */
	public class CoreData
	{
		/**
		 * 版本号
		 * 程序构建版本 + 功能版本 + 更新版本 + 编译版本号
		 */
		public static const VERSION:String = "0.0.0.1";
		
		/**
		 * 是否为调试版本
		 */
		public static var isDebug:Boolean;
		
		/**
		 * 调试配置文件路径
		 */
		public static const DEBUG:String = "data/debug.xml";
		
		/**
		 * 配置文件路径
		 */
		public static const CONFIG:String = "data/config.xml";
		
		/**
		 * 游戏列表文件路径
		 */
		public static const GAMES:String = "data/games.xml";
	
	}
}
