package com.ourgame.mahjong.model
{
	import com.wecoit.mvc.Model;
	
	/**
	 * 代理数据模型
	 * @author SiaoLeon
	 */
	public class ProxyModel extends Model
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		/**
		 * 当前游戏路径
		 * @return
		 */
		public function get currentGamePath():String
		{
			return (this.context.getModel(GameModel) as GameModel).current.path;
		}
		
		/**
		 * 联众ID
		 * @return
		 */
		public function get ourgameID():String
		{
			return (this.context.getModel(UserModel) as UserModel).ourgameID;
		}
		
		/**
		 * 用户名
		 * @return
		 */
		public function get username():String
		{
			return (this.context.getModel(UserModel) as UserModel).username;
		}
		
		/**
		 * 角色名
		 * @return
		 */
		public function get rolename():String
		{
			return (this.context.getModel(UserModel) as UserModel).rolename;
		}
		
		/**
		 * 昵称
		 * @return
		 */
		public function get nickname():String
		{
			return (this.context.getModel(UserModel) as UserModel).nickname;
		}
		
		/**
		 * 证书(长)
		 */
		public function get ticket():String
		{
			return (this.context.getModel(UserModel) as UserModel).ticket;
		}
		
		/**
		 * 渠道号
		 */
		public function get channelID():int
		{
			return (this.context.getModel(UserModel) as UserModel).channelID;
		}
		
		/**
		 * 头像
		 */
		public function get headImage():String
		{
			return (this.context.getModel(UserModel) as UserModel).headImage;
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function ProxyModel()
		{
			super();
		}
	
		// -------------------------------------------------------------------------------------------------------- 方法
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
