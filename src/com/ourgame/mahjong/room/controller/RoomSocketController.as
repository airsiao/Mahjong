package com.ourgame.mahjong.room.controller
{
	import com.ourgame.mahjong.libaray.DataExchange;
	import com.ourgame.mahjong.libaray.vo.socket.MJDataPack;
	import com.ourgame.mahjong.main.method.SocketMethod;
	import com.ourgame.mahjong.main.model.MainSocketModel;
	import com.ourgame.mahjong.message.CReqEnterTable;
	import com.ourgame.mahjong.message.CReqLeaveRoom;
	import com.ourgame.mahjong.message.CReqTables;
	import com.ourgame.mahjong.protocol.MJRoomProtocol;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	
	/**
	 * 房间Socket控制器
	 * @author SiaoLeon
	 */
	public class RoomSocketController extends Controller
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var center:DataExchange;
		
		private var socket:MainSocketModel;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function RoomSocketController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(SocketMethod.RECIVED(MainSocketModel), RECIVED);
			
			this.register(RoomMethod.LEAVE_ROOM, LEAVE_ROOM);
			this.register(RoomMethod.TABLE_LIST, TABLE_LIST);
			this.register(RoomMethod.ENTER_TABLE, ENTER_TABLE);
			this.register(RoomMethod.STAND_BY, STAND_BY);
			this.register(RoomMethod.QUICK_START, QUICK_START);
			this.register(RoomMethod.TABLE_INFO, TABLE_INFO);
			
			this.center = this.context.getModel(DataExchange) as DataExchange;
			this.socket = this.context.getModel(MainSocketModel) as MainSocketModel;
		}
		
		override public function onRemove():void
		{
			this.socket = null;
		}
		
		// -------------------------------------------------------------------------------------------------------- 发送
		
		private function LEAVE_ROOM(notice:INotice):void
		{
			var body:CReqLeaveRoom = new CReqLeaveRoom();
			body.roomId = this.center.room.id;
			
			Log.debug("发送离开房间请求", body);
			
			this.socket.send(MJRoomProtocol.CLIENT + MJRoomProtocol.OGID_ROOM_LEAVE, body);
		}
		
		private function TABLE_LIST(notice:INotice):void
		{
			var body:CReqTables = new CReqTables();
			body.roomId = this.center.room.id;
			
			Log.debug("发送获取桌子列表请求", body);
			
			this.socket.send(MJRoomProtocol.CLIENT + MJRoomProtocol.OGID_TABLE_LIST, body);
		}
		
		private function ENTER_TABLE(notice:INotice):void
		{
			var body:CReqEnterTable = new CReqEnterTable();
			body.roomId = this.center.room.id;
			body.tableId = notice.params;
			
			Log.debug("发送进入桌子请求", body);
			
			this.socket.send(MJRoomProtocol.CLIENT + MJRoomProtocol.OGID_TABLE_ENTER, body);
		}
		
		private function STAND_BY(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function QUICK_START(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function TABLE_INFO(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		// -------------------------------------------------------------------------------------------------------- 接收
		
		private function RECIVED(notice:INotice):void
		{
			var data:MJDataPack = notice.params;
			
			switch (data.type)
			{
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_ROOM_LEAVE:
					this.ON_ROOM_LEAVE(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_TABLE_LIST:
					this.ON_TABLE_LIST(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_TABLE_ENTER:
					this.ON_TABLE_ENTER(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_STAND_BY:
					this.ON_STAND_BY(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_TABLE_PLAYER_COUNT:
					this.ON_TABLE_PLAYER_COUNT(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_TABLE_DISMISS:
					this.ON_TABLE_DISMISS(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_TABLE_CREATE:
					this.ON_TABLE_CREAT(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_QUICK_START:
					this.ON_QUICK_START(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_TABLE_INFO:
					this.ON_TABLE_INFO(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_TABLE_INVITE:
					this.ON_TABLE_INVITE(data);
					break;
			}
		}
		
		private function ON_ROOM_LEAVE(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_TABLE_LIST(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_TABLE_ENTER(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_STAND_BY(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_TABLE_PLAYER_COUNT(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_TABLE_DISMISS(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_TABLE_CREAT(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_QUICK_START(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_TABLE_INFO(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ON_TABLE_INVITE(data:MJDataPack):void
		{
			// TODO Auto Generated method stub
		
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
