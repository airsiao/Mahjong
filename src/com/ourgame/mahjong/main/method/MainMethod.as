package com.ourgame.mahjong.main.method
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 主程序消息标头
	 * @author SiaoLeon
	 */
	public class MainMethod
	{
		
		/**
		 * 消息基础值
		 */
		private static const BASE:String = getQualifiedClassName(MainMethod) + "::";
		
		/**
		 * 加载用户信息
		 */
		public static const LOAD_USERINFO:String = BASE + "LOAD_USERINFO";
		
		/**
		 * 加载用户信息错误
		 */
		public static const LOAD_USERINFO_ERROR:String = BASE + "LOAD_USERINFO_ERROR";
		
		/**
		 * 加载用户信息完成
		 */
		public static const LOAD_USERINFO_COMPLETE:String = BASE + "LOAD_USERINFO_COMPLETE";
		
		/**
		 * 加载游戏
		 * params GameType 游戏ID
		 */
		public static const LOAD_GAME:String = BASE + "LOAD_GAME";
		
		/**
		 * 加载游戏错误
		 * params GameInfo 游戏信息
		 */
		public static const LOAD_GAME_ERROR:String = BASE + "LOAD_GAME_ERROR";
		
		/**
		 * 加载游戏进度
		 * params int 百分比进度
		 */
		public static const LOAD_GAME_PROGRESS:String = BASE + "LOAD_GAME_PROGRESS";
		
		/**
		 * 加载游戏完成
		 * params GameInfo 游戏信息
		 */
		public static const LOAD_GAME_COMPLETE:String = BASE + "LOAD_GAME_COMPLETE";
	
	}
}
