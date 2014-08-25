package com.ourgame.mahjong.room.method
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 房间消息标头
	 * @author SiaoLeon
	 */
	public class RoomMethod
	{
		/**
		 * 消息基础值
		 */
		private static const BASE:String = getQualifiedClassName(RoomMethod) + "::";
		
		/**
		 * 房间列表
		 */
		public static const ROOM_LIST:String = BASE + "ROOM_LIST";
		
		/**
		 * 房间列表错误
		 */
		public static const ROOM_LIST_ERROR:String = BASE + "ROOM_LIST_ERROR";
		
		/**
		 * 房间列表成功
		 */
		public static const ROOM_LIST_SUCCESS:String = BASE + "ROOM_LIST_SUCCESS";
		
		/**
		 * 进入房间
		 * params uint 房间ID
		 */
		public static const ENTER_ROOM:String = BASE + "ENTER_ROOM";
		
		/**
		 * 进入房间错误
		 * params EnterRoomError 错误ID
		 */
		public static const ENTER_ROOM_ERROR:String = BASE + "ENTER_ROOM_ERROR";
		
		/**
		 * 进入房间成功
		 */
		public static const ENTER_ROOM_SUCCESS:String = BASE + "ENTER_ROOM_SUCCESS";
		
		/**
		 * 离开房间
		 */
		public static const LEAVE_ROOM:String = BASE + "LEAVE_ROOM";
		
		/**
		 * 离开房间错误
		 */
		public static const LEAVE_ROOM_ERROR:String = BASE + "LEAVE_ROOM_ERROR";
		
		/**
		 * 离开房间成功
		 */
		public static const LEAVE_ROOM_SUCCESS:String = BASE + "LEAVE_ROOM_SUCCESS";
		
		/**
		 * 桌子列表
		 */
		public static const TABLE_LIST:String = BASE + "TABLE_LIST";
		
		/**
		 * 桌子列表错误
		 */
		public static const TABLE_LIST_ERROR:String = BASE + "TABLE_LIST_ERROR";
		
		/**
		 * 桌子列表成功
		 */
		public static const TABLE_LIST_SUCCESS:String = BASE + "TABLE_LIST_SUCCESS";
		
		/**
		 * 进入桌子
		 * params uint 桌子ID
		 */
		public static const ENTER_TABLE:String = BASE + "ENTER_TABLE";
		
		/**
		 * 进入桌子错误
		 * params EnterTableError 错误ID
		 */
		public static const ENTER_TABLE_ERROR:String = BASE + "ENTER_TABLE_ERROR";
		
		/**
		 * 进入桌子成功
		 */
		public static const ENTER_TABLE_SUCCESS:String = BASE + "ENTER_TABLE_SUCCESS";
		
		/**
		 * 离开桌子
		 */
		public static const LEAVE_TABLE:String = BASE + "LEAVE_TABLE";
		
		/**
		 * 离开桌子失败
		 * params LeaveTableError 错误ID
		 */
		public static const LEAVE_TABLE_ERROR:String = BASE + "LEAVE_TABLE_ERROR";
		
		/**
		 * 离开桌子成功
		 */
		public static const LEAVE_TABLE_SUCCESS:String = BASE + "LEAVE_TABLE_SUCCESS";
		
		/**
		 * 准备
		 */
		public static const STAND_BY:String = BASE + "STAND_BY";
		
		/**
		 * 准备错误
		 */
		public static const STAND_BY_ERROR:String = BASE + "STAND_BY_ERROR";
		
		/**
		 * 准备成功
		 */
		public static const STAND_BY_SUCCESS:String = BASE + "STAND_BY_SUCCESS";
		
		/**
		 * 更新房间用户数
		 * params Array 房间ID数组
		 */
		public static const UPDATE_PLAYER_COUNT:String = BASE + "UPDATE_PLAYER_COUNT";
		
		/**
		 * 快速开始
		 */
		public static const QUICK_START:String = BASE + "QUICK_START";
		
		/**
		 * 快速开始错误
		 */
		public static const QUICK_START_ERROR:String = BASE + "QUICK_START_ERROR";
		
		/**
		 * 快速开始成功
		 */
		public static const QUICK_START_SUCCESS:String = BASE + "QUICK_START_SUCCESS";
		
		/**
		 * 桌子信息
		 * params uint 桌子ID
		 */
		public static const TABLE_INFO:String = BASE + "TABLE_INFO";
		
		/**
		 * 邀请进入桌子
		 * params uint 桌子ID
		 */
		public static const TABLE_INVITE:String = BASE + "TABLE_INVITE";
	
	}
}
