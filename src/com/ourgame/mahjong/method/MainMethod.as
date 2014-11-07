package com.ourgame.mahjong.method
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 主要消息标头
	 * @author SiaoLeon
	 */
	public class MainMethod
	{
		/**
		 * 消息基础值
		 */
		private static const BASE:String = getQualifiedClassName(MainMethod) + "::";
		
		/**
		 * 加载配置数据错误
		 */
		public static const LOAD_CONFIG_ERROR:String = BASE + "LOAD_CONFIG_ERROR";
		
		/**
		 * 加载配置数据完成
		 */
		public static const LOAD_CONFIG_COMPLETE:String = BASE + "LOAD_CONFIG_COMPLETE";
		
		/**
		 * 加载用户数据错误
		 */
		public static const LOAD_USERINFO_ERROR:String = BASE + "LOAD_USERINFO_ERROR";
		
		/**
		 * 加载用户数据完成
		 */
		public static const LOAD_USERINFO_COMPLETE:String = BASE + "LOAD_USERINFO_COMPLETE";
		
		/**
		 * 加载游戏错误
		 */
		public static const LOAD_GAME_ERROR:String = BASE + "LOAD_GAME_ERROR";
		
		/**
		 * 加载游戏完成
		 */
		public static const LOAD_GAME_COMPLETE:String = BASE + "LOAD_GAME_COMPLETE";
		
		/**
		 * 进入游戏
		 * params GameInfo 游戏对象
		 */
		public static const ENTER_GAME:String = BASE + "ENTER_GAME";
	
	}
}
