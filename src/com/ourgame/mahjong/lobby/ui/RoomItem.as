package com.ourgame.mahjong.lobby.ui
{
	import com.ourgame.mahjong.libaray.vo.RoomInfo;
	import com.ourgame.mahjong.lobby.enum.UIDefinition;
	import com.ourgame.mahjong.main.uitls.currency;
	import com.wecoit.component.StateButton;
	import com.wecoit.core.AssetsManager;
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/**
	 * 房间项目
	 * @author SiaoLeon
	 */
	public class RoomItem extends StateButton
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		private var _data:RoomInfo;
		
		public function get data():RoomInfo
		{
			return this._data;
		}
		
		public function set data(value:RoomInfo):void
		{
			this._data = value;
			
			(this.content["Count"] as TextField).text = this.data.playerCount.toString();
			(this.content["Buyin"] as TextField).text = currency(this.data.buyin) + "豆带入";
			(this.content["Title"] as MovieClip).gotoAndStop(this.data.id);
		}
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var content:MovieClip;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function RoomItem()
		{
			super();
			
			this.content = AssetsManager.instance.getDefinitionMovieClip(UIDefinition.RoomItem);
			(this.content["Title"] as MovieClip).gotoAndStop(1);
			this.addChild(this.content);
			
			this.width = this.content.width;
			this.height = this.content.height + 5;
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		override protected function onNormal():void
		{
			this.content.y = 0;
			this.draw(null, null);
		}
		
		override protected function onMouseOver():void
		{
			this.content.y = -5;
			this.draw(0XFF0000, 0);
		}
	
	}
}
