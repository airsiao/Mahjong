package com.ourgame.mahjong.table.controller
{
	import com.ourgame.mahjong.libaray.data.CommonData;
	import com.ourgame.mahjong.libaray.vo.socket.MJDataPack;
	import com.ourgame.mahjong.main.method.SocketMethod;
	import com.ourgame.mahjong.main.model.MainSocketModel;
	import com.ourgame.mahjong.message.CReqLeaveRoom;
	import com.ourgame.mahjong.message.NtfInviteGame;
	import com.ourgame.mahjong.protocol.MJRoomProtocol;
	import com.ourgame.mahjong.protocol.MJTableProtocol;
	import com.ourgame.mahjong.table.method.TableMethod;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	
	/**
	 * 房间Socket控制器
	 * @author SiaoLeon
	 */
	public class TableSocketController extends Controller
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var socket:MainSocketModel;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function TableSocketController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(SocketMethod.RECIVED(MainSocketModel), RECIVED);
			
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
			body.roomId = CommonData.room.id;
			
			Log.debug("发送离开房间请求", body);
			
			this.socket.send(MJRoomProtocol.CLIENT + MJRoomProtocol.OGID_ROOM_LEAVE, body);
		}
		
		// -------------------------------------------------------------------------------------------------------- 接收
		
		private function RECIVED(notice:INotice):void
		{
			var data:MJDataPack = notice.params;
			
			switch (data.type)
			{
				case MJTableProtocol.SERVER + MJTableProtocol.OGID_GAME_INVITE:
					this.ON_GAME_INVITE(data);
					break;
			}
		}
		
		private function ON_GAME_INVITE(data:MJDataPack):void
		{
			var body:NtfInviteGame = new NtfInviteGame();
			body.mergeFrom(data.body);
			
			Log.debug("收到游戏邀请消息", body);
			
			CommonData.gameID = body.gameId;
			
			this.notify(TableMethod.GAME_INVITE, body.tableId);
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
