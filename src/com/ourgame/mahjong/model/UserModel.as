package com.ourgame.mahjong.model
{
	import com.ourgame.mahjong.data.CoreData;
	import com.ourgame.mahjong.method.MainMethod;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.core.FlashPlayer;
	import com.wecoit.data.Config;
	import com.wecoit.debug.Log;
	import com.wecoit.events.BytesEvent;
	import com.wecoit.loader.BytesLoader;
	import com.wecoit.mvc.Application;
	import com.wecoit.mvc.Model;
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
		
		private var _ourgameID:String;
		
		/**
		 * 联众ID
		 */
		public function get ourgameID():String
		{
			return this._ourgameID;
		}
		
		private var _username:String;
		
		/**
		 * 用户名
		 */
		public function get username():String
		{
			return this._username;
		}
		
		private var _rolename:String;
		
		/**
		 * 角色名
		 */
		public function get rolename():String
		{
			return this._rolename;
		}
		
		private var _nickname:String;
		
		/**
		 * 昵称
		 */
		public function get nickname():String
		{
			return this._nickname;
		}
		
		private var _ticket:String;
		
		/**
		 * 证书（长）
		 */
		public function get ticket():String
		{
			return this._ticket;
		}
		
		private var _channelID:uint;
		
		/**
		 * 渠道号
		 */
		public function get channelID():uint
		{
			return this._channelID;
		}
		
		private var _headImage:String;
		
		/**
		 * 头像
		 */
		public function get headImage():String
		{
			return this._headImage;
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
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
			var api:String = stampUrl(AssetsManager.instance.getConfig("config").getString("HeadImageApi") + "?username=" + this.ourgameID);
			
			Log.debug("请求获取用户头像地址", api);
			
			HttpService.REQUEST(new URLRequest(api), onHeadComplete, onHeadFault);
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function loadInfoFromFlashVars():void
		{
			this._ourgameID = Application.stage.loaderInfo.parameters["OurgameID"];
			this._username = Application.stage.loaderInfo.parameters["UserName"];
			this._rolename = Application.stage.loaderInfo.parameters["RoleName"];
			this._nickname = Application.stage.loaderInfo.parameters["NickName"];
			this._ticket = Application.stage.loaderInfo.parameters["Ticket"];
			this._channelID = Application.stage.loaderInfo.parameters["ChannelID"];
			
			if (this.ourgameID == null || this.ourgameID == "" || this.rolename == null || this.rolename == "" || this.nickname == null || this.nickname == "")
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
			
			this._ourgameID = config.getValue("ourgameID");
			this._username = config.getValue("username");
			this._rolename = config.getValue("rolename");
			this._nickname = config.getValue("nickname");
			this._ticket = config.getValue("ticket");
			this._channelID = config.getValue("channelID");
			
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
				
				this._headImage = head["Url"];
			}
		}
		
		private function onHeadFault(event:Event=null):void
		{
			Log.error("用户头像地址获取失败");
			
			this._headImage = AssetsManager.instance.getConfig("config").getString("HeadImageDefault");
		}
	
	}
}
