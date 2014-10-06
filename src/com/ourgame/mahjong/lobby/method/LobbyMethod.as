package com.ourgame.mahjong.lobby.method
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 大厅消息标头
	 * @author SiaoLeon
	 */
	public class LobbyMethod
	{
		/**
		 * 消息基础值
		 */
		private static const BASE:String = getQualifiedClassName(LobbyMethod) + "::";
		
		/**
		 * 登录
		 */
		public static const LOGIN:String = BASE + "LOGIN";
		
		/**
		 * 登录错误
		 * params uint 登录结果
		 */
		public static const LOGIN_ERROR:String = BASE + "LOGIN_ERROR";
		
		/**
		 * 登录成功
		 */
		public static const LOGIN_SUCCESS:String = BASE + "LOGIN_SUCCESS";
		
		/**
		 * 登出
		 */
		public static const LOGOUT:String = BASE + "LOGOUT";
		
		/**
		 * 登出错误
		 * params uint 登出结果
		 */
		public static const LOGOUT_ERROR:String = BASE + "LOGOUT_ERROR";
		
		/**
		 * 登出成功
		 */
		public static const LOGOUT_SUCCESS:String = BASE + "LOGOUT_SUCCESS";
		
		/**
		 * 更新排行榜
		 */
		public static const UPDATE_RANK:String = BASE + "UPDATE_RANK";
		
		/**
		 * 更新用户信息
		 */
		public static const UPDATE_USER:String = BASE + "UPDATE_USER";
		
		/**
		 * 更新用户人数
		 */
		public static const UPDATE_USER_COUNT:String = BASE + "UPDATE_USER_COUNT";
		
		/**
		 * 发送喇叭
		 */
		public static const SPEAKER:String = BASE + "SPEAKER";
		
		/**
		 * 系统消息
		 */
		public static const NOTICE:String = BASE + "NOTICE";
	
	/**
	 * 进入房间
	 * params RoomInfo 房间对象
	 */
		 //		public static const ENTER_ROOM:String = BASE + "ENTER_ROOM";
	
	}
}
