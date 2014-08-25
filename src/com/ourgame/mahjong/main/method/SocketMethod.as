package com.ourgame.mahjong.main.method
{
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Socket消息标头
	 * @author SiaoLeon
	 */
	public class SocketMethod
	{
		/**
		 * 连接
		 */
		public static function CONNECT(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "CONNECT";
		}
		
		/**
		 * 连接错误
		 */
		public static function CONNECT_ERROR(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "CONNECT_ERROR";
		}
		
		/**
		 * 连接成功
		 */
		public static function CONNECT_SUCCESS(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "CONNECT_SUCCESS";
		}
		
		/**
		 * 关闭
		 */
		public static function CLOSE(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "CLOSE";
		}
		
		/**
		 * 关闭后
		 */
		public static function CLOSED(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "CLOSED";
		}
		
		/**
		 * 被断开
		 */
		public static function DISCONECT(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "DISCONECT";
		}
		
		/**
		 * 发送数据
		 * params IBytesData Socket字节数据
		 */
		public static function SEND(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "SEND";
		}
		
		/**
		 * 发出数据
		 * params IBytesData Socket字节数据
		 */
		public static function FLUSH(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "FLUSH";
		}
		
		/**
		 * 模拟数据
		 * params IBytesData Socket字节数据
		 */
		public static function PUSH(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "PUSH";
		}
		
		/**
		 * 接收数据
		 * params IBytesData Socket字节数据
		 */
		public static function RECIVED(model:Class):String
		{
			return getQualifiedClassName(model) + "::" + "RECIVED";
		}
	
	}
}
