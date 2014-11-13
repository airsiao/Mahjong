package com.ourgame.mahjong.view
{
	import com.ourgame.mahjong.enum.UIDefinition;
	import com.ourgame.mahjong.model.UserModel;
	import com.ourgame.mahjong.ui.LayerManager;
	import com.wecoit.component.ButtonClip;
	import com.wecoit.component.Stack;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.display.Align;
	import com.wecoit.mvc.View;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * 公共视图
	 * @author SiaoLeon
	 */
	public class CommonView extends View
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		public function set nickname(value:String):void
		{
			(this.userinfo["Name"] as TextField).text = value;
		}
		
		public function set headImage(value:String):void
		{
		}
		
		public function set coins(value:uint):void
		{
			(this.userinfo["Coins"] as TextField).text = value.toString();
		}
		
		public function set level(value:uint):void
		{
			(this.expLevel["Level"] as TextField).text = "Lv." + value.toString();
		}
		
		private var _exp:uint;
		
		public function set exp(value:uint):void
		{
			this._exp = value;
			
			var pre:uint = Math.round(this._exp * 100 / this._maxExp);
			(this.expLevel["Progress"] as MovieClip).width = 5 + 105 * pre / 100;
			(this.expLevel["Progress"] as MovieClip).visible = this._exp > 0;
		}
		
		private var _maxExp:uint;
		
		public function set maxExp(value:uint):void
		{
			this._maxExp = value;
			
			var pre:uint = Math.round(this._exp * 100 / this._maxExp);
			(this.expLevel["Progress"] as MovieClip).width = 5 + 105 * pre / 100;
			(this.expLevel["Progress"] as MovieClip).visible = this._exp > 0;
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var background:Bitmap;
		
		private var line:Bitmap;
		
		private var logo:Bitmap;
		
		private var userinfo:MovieClip;
		
		private var expLevel:MovieClip;
		
		private var btnRecharge:ButtonClip;
		
		private var menu:Stack;
		
		private var btnScreenShot:ButtonClip;
		
		private var btnFullScreen:ButtonClip;
		
		private var mcPing:MovieClip;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function CommonView()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.background = AssetsManager.instance.getDefinitionBitmap(UIDefinition.CommonBackground);
			LayerManager.instance.background.addChild(this.background);
			
			this.line = AssetsManager.instance.getDefinitionBitmap(UIDefinition.Line);
			this.line.x = 455;
			this.line.y = 20;
			LayerManager.instance.background.addChild(this.line);
			
			this.logo = AssetsManager.instance.getDefinitionBitmap(UIDefinition.Logo);
			this.logo.x = 20;
			this.logo.y = 15;
			LayerManager.instance.foreground.addChild(this.logo);
			
			this.userinfo = AssetsManager.instance.getDefinitionMovieClip(UIDefinition.UserInfo);
			this.userinfo.x = 280;
			this.userinfo.y = 12;
			LayerManager.instance.foreground.addChild(this.userinfo);
			
			this.expLevel = AssetsManager.instance.getDefinitionMovieClip(UIDefinition.ExpLevel);
			this.expLevel.x = 480;
			this.expLevel.y = 18;
			LayerManager.instance.foreground.addChild(this.expLevel);
			
			this.btnRecharge = new ButtonClip(AssetsManager.instance.getDefinitionMovieClip(UIDefinition.ButtonRecharge));
			this.btnRecharge.x = 410;
			this.btnRecharge.y = 28;
			LayerManager.instance.foreground.addChild(this.btnRecharge);
			
			this.menu = new Stack();
			this.menu.alignH = Align.RIGHT;
			this.menu.alignV = Align.TOP;
			this.menu.contentAlignH = Align.RIGHT;
			this.menu.contentAlignV = Align.TOP;
			this.menu.offsetX = -10;
			this.menu.offsetY = 5;
			this.menu.spacing = 3;
			LayerManager.instance.background.addChild(this.menu);
			
			this.btnScreenShot = new ButtonClip(AssetsManager.instance.getDefinitionMovieClip(UIDefinition.ButtonScreenShot));
			this.menu.addChild(this.btnScreenShot);
			
			this.mcPing = AssetsManager.instance.getDefinitionMovieClip(UIDefinition.ButtonPing);
			this.mcPing.gotoAndStop(1);
			this.menu.addChild(this.mcPing);
			
			this.btnRecharge.addEventListener(MouseEvent.CLICK, onRecharge);
			
			this.init();
		}
		
		override public function onRemove():void
		{
			this.btnRecharge.removeEventListener(MouseEvent.CLICK, onRecharge);
			
			LayerManager.instance.foreground.removeChild(this.btnRecharge);
			this.btnRecharge = null;
			
			LayerManager.instance.foreground.removeChild(this.expLevel);
			this.expLevel = null;
			
			LayerManager.instance.foreground.removeChild(this.userinfo);
			this.userinfo = null;
			
			LayerManager.instance.foreground.removeChild(this.logo);
			this.logo = null;
			
			LayerManager.instance.background.removeChild(this.line);
			this.line = null;
			
			LayerManager.instance.background.removeChild(this.background);
			this.background = null;
		}
		
		public function bindData():void
		{
			this.bind((this.context.getModel(UserModel) as UserModel).user, this, {nickname: "nickname", headImage: "headImage", coins: "coins", level: "level", experience: "exp", maxExperience: "maxExp"});
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function init():void
		{
			this.nickname = "";
			this.coins = 0;
			this.level = 0;
			this.exp = 0;
		}
		
		private function onRecharge(event:MouseEvent):void
		{
		
		}
	
	}
}
