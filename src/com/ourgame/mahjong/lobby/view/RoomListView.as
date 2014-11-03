package com.ourgame.mahjong.lobby.view
{
	import com.ourgame.mahjong.libaray.data.CommonData;
	import com.ourgame.mahjong.libaray.vo.RoomInfo;
	import com.ourgame.mahjong.lobby.enum.UIDefinition;
	import com.ourgame.mahjong.lobby.ui.RoomItem;
	import com.ourgame.mahjong.main.ui.LayerManager;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.wecoit.core.AssetsManager;
	import com.wecoit.mvc.View;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	
	/**
	 * 房间列表视图
	 * @author SiaoLeon
	 */
	public class RoomListView extends View
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var items:Vector.<RoomItem>;
		
		private var background:Bitmap;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function RoomListView()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.items = new Vector.<RoomItem>();
			
			this.background = AssetsManager.instance.getDefinitionBitmap(UIDefinition.RoomListBacground);
			this.background.x = 3;
			this.background.y = 118;
			LayerManager.instance.foreground.addChild(this.background);
		}
		
		override public function onRemove():void
		{
			for each (var item:RoomItem in this.items)
			{
				item.remove();
			}
			
			LayerManager.instance.foreground.removeChild(this.background);
			this.background = null;
		}
		
		public function show():void
		{
			for (var i:int = 0; i < CommonData.roomList.length; i++)
			{
				var info:RoomInfo = CommonData.roomList.element(i);
				var item:RoomItem = new RoomItem();
				item.x = 15 + i % 3 * 215;
				item.y = 185 + Math.floor(i / 3) * 200;
				item.data = info;
				item.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
				LayerManager.instance.foreground.addChild(item);
				this.items.push(item);
			}
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		protected function onClick(event:MouseEvent):void
		{
			var target:RoomInfo = (event.target as RoomItem).data;
			this.notify(RoomMethod.ENTER_ROOM, target.id);
		}
	
	}
}
