package com.ourgame.mahjong.controller
{
	import com.ourgame.mahjong.data.CoreData;
	import com.ourgame.mahjong.method.MainMethod;
	import com.ourgame.mahjong.model.ConfigModel;
	import com.ourgame.mahjong.model.GameModel;
	import com.ourgame.mahjong.model.UserModel;
	import com.ourgame.mahjong.state.MainState;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	
	/**
	 * 启动控制器
	 * @author SiaoLeon
	 */
	public class StartupController extends Controller
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function StartupController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(MainMethod.LOAD_CONFIG_ERROR, LOAD_CONFIG_ERROR);
			this.register(MainMethod.LOAD_CONFIG_COMPLETE, LOAD_CONFIG_COMPLETE);
			this.register(MainMethod.LOAD_USERINFO_ERROR, LOAD_USERINFO_ERROR);
			this.register(MainMethod.LOAD_USERINFO_COMPLETE, LOAD_USERINFO_COMPLETE);
			
			this.STARTUP();
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function STARTUP(notice:INotice=null):void
		{
			Log.info("应用程序启动，Ver:" + CoreData.VERSION);
			
			(this.context.getModel(ConfigModel) as ConfigModel).load();
		}
		
		private function LOAD_CONFIG_ERROR(notice:INotice):void
		{
		}
		
		private function LOAD_CONFIG_COMPLETE(notice:INotice):void
		{
			(this.context.getModel(GameModel) as GameModel).init();
			(this.context.getModel(UserModel) as UserModel).load();
		}
		
		private function LOAD_USERINFO_ERROR(notice:INotice):void
		{
		}
		
		private function LOAD_USERINFO_COMPLETE(notice:INotice):void
		{
			var model:UserModel = this.context.getModel(UserModel) as UserModel;
			
			Log.info("用户数据加载完成", "帐号：" + model.ourgameID, "用户名：" + model.username, "角色名：" + model.rolename, "昵称：" + model.nickname);
			
			(this.context as MainState).common.show();
			(this.context as MainState).selector.show();
		}
	
	}
}
