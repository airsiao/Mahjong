package com.ourgame.mahjong.table.method
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 桌子消息标头
	 * @author SiaoLeon
	 */
	public class TableMethod
	{
		/**
		 * 消息基础值
		 */
		private static const BASE:String = getQualifiedClassName(TableMethod) + "::";
		
		/**
		 * 邀请进入游戏
		 * params uint 游戏ID
		 */
		public static const GAME_INVITE:String = BASE + "GAME_INVITE";
		
		/**
		 * 坐下
		 * params uint 座位号
		 */
		public static const SIT_DOWN:String = BASE + "SIT_DOWN";
		
		/**
		 * 坐下错误
		 * params SitDownError 错误ID
		 */
		public static const SIT_DOWN_ERROR:String = BASE + "SIT_DOWN_ERROR";
		
		/**
		 * 坐下成功
		 */
		public static const SIT_DOWN_SUCCESS:String = BASE + "SIT_DOWN_SUCCESS";
		
		/**
		 * 站起
		 */
		public static const STAND_UP:String = BASE + "STAND_UP";
		
		/**
		 * 站起错误
		 * params SitDownError 错误ID
		 */
		public static const STAND_UP_ERROR:String = BASE + "STAND_UP_ERROR";
		
		/**
		 * 站起成功
		 * params StandupReason 原因
		 */
		public static const STAND_UP_SUCCESS:String = BASE + "STAND_UP_SUCCESS";
		
		/**
		 * 自动买入
		 * params Boolean 是否自动买入
		 */
		public static const AUTO_BUYIN:String = BASE + "AUTO_BUYIN";
		
		/**
		 * 下局离开
		 * params Boolean 是否下局离开
		 */
		public static const AUTO_LEAVE:String = BASE + "AUTO_LEAVE";
		
		/**
		 * 请求买入
		 */
		public static const BUY_OUT:String = BASE + "BUY_OUT";
		
		/**
		 * 买入
		 */
		public static const BUY_IN:String = BASE + "BUY_IN";
	
	}
}
