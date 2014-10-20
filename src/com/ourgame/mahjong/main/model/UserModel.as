package com.ourgame.mahjong.main.model
{
	import com.ourgame.mahjong.Main;
	import com.ourgame.mahjong.libaray.DataExchange;
	import com.ourgame.mahjong.main.data.CoreData;
	import com.ourgame.mahjong.main.method.MainMethod;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.core.FlashPlayer;
	import com.wecoit.data.Config;
	import com.wecoit.debug.Log;
	import com.wecoit.events.BytesEvent;
	import com.wecoit.loader.BytesLoader;
	import com.wecoit.mvc.Application;
	import com.wecoit.mvc.Model;
	import com.wecoit.mvc.State;
	import com.wecoit.net.services.HttpService;
	import com.wecoit.utils.string.stampUrl;
	
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	
	/**
	 * 用户数据模型
	 * @author SiaoLeon
	 */
	public class UserModel extends Model
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var data:DataExchange;
		
		private var loader:BytesLoader;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function UserModel()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			if (ExternalInterface.available)
			{
				try
				{
					//注册头像更新回调
					ExternalInterface.addCallback("completeHeadUpload", this.updateHead);
				}
				catch (err:Error)
				{
				}
			}
			
			this.data = ((this.context as State).manager as Main).info.data;
			
			this.loader = new BytesLoader();
			this.loader.addEventListener(BytesEvent.ERROR, onLoadError);
			this.loader.addEventListener(BytesEvent.COMPLETE, onLoadComplete);
		}
		
		override public function onRemove():void
		{
			if (ExternalInterface.available)
			{
				try
				{
					ExternalInterface.addCallback("completeHeadUpload", null);
				}
				catch (err:Error)
				{
				}
			}
			
			this.loader.removeEventListener(BytesEvent.ERROR, onLoadError);
			this.loader.removeEventListener(BytesEvent.COMPLETE, onLoadComplete);
			this.loader = null;
		}
		
		/**
		 * 加载用户数据
		 */
		public function load():void
		{
			if (FlashPlayer.isDebug)
			{
				this.loader.load(stampUrl(CoreData.DEBUG));
			}
			else
			{
				this.loadInfoFromFlashVars();
			}
		}
		
		/**
		 * 更新用户头像
		 */
		public function updateHead():void
		{
			var api:String = stampUrl(AssetsManager.instance.getConfig("services").getString("HeadImageApi") + "?username=" + this.data.ourgameID);
			
			Log.debug("请求获取用户头像地址", api);
			
			HttpService.REQUEST(new URLRequest(api), onHeadComplete, onHeadFault);
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function loadInfoFromFlashVars():void
		{
			this.data.ourgameID = Application.stage.loaderInfo.parameters["OurgameID"];
			this.data.username = Application.stage.loaderInfo.parameters["UserName"];
			this.data.rolename = Application.stage.loaderInfo.parameters["RoleName"];
			this.data.nickname = Application.stage.loaderInfo.parameters["NickName"];
			this.data.ticket = Application.stage.loaderInfo.parameters["Ticket"];
			this.data.channelID = Application.stage.loaderInfo.parameters["ChannelID"];
			
			if (this.data.ourgameID == null)
			{
				this.notify(MainMethod.LOAD_USERINFO_ERROR);
			}
			else
			{
				this.updateHead();
				
				this.notify(MainMethod.LOAD_USERINFO_COMPLETE);
			}
		}
		
		private function onLoadError(event:BytesEvent):void
		{
			this.loadInfoFromFlashVars();
		}
		
		private function onLoadComplete(event:BytesEvent):void
		{
			CoreData.isDebug = true;
			
			var config:Config = new Config(this.loader.content);
			
			this.data.ourgameID = config.getValue("ourgameID");
			this.data.username = config.getValue("username");
			this.data.rolename = config.getValue("rolename");
			this.data.nickname = config.getValue("nickname");
			this.data.ticket = config.getValue("ticket");
			this.data.channelID = config.getValue("channelID");
			
			AssetsManager.instance.saveAsset(config.name, this.loader.content);
			
			this.updateHead();
			
			this.notify(MainMethod.LOAD_USERINFO_COMPLETE);
		}
		
		private function onHeadComplete(data:Object):void
		{
			data = JSON.parse(String(data));
			
			if (data["Result"] != 1 || data["Data"] == null || data["Data"]["Avatars"] == null || data["Data"]["Avatars"].length <= 0)
			{
				this.onHeadFault();
			}
			else
			{
				var head:Object;
				
				for each (var info:Object in(data["Data"]["Avatars"] as Array))
				{
					if (head == null)
					{
						head = info;
						continue;
					}
					
					if (info["Width"] < 100 || info["Height"] < 100)
					{
						if (info["Width"] > head["Width"] && info["Height"] > head["Height"])
						{
							head = info;
						}
						continue;
					}
					else
					{
						if (info["Width"] < head["Width"] && info["Height"] < head["Height"])
						{
							head = info;
						}
						continue;
					}
				}
				
				Log.debug("用户头像地址获取成功", head["Url"]);
				
				this.data.user.headImage = head["Url"];
			}
		}
		
		private function onHeadFault(event:Event=null):void
		{
			Log.error("用户头像地址获取失败");
			
			this.data.user.headImage = AssetsManager.instance.getConfig("services").getString("HeadImageDefault");
		}
	
	}
}
