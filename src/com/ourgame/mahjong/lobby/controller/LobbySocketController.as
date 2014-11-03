package com.ourgame.mahjong.lobby.controller
{
	import com.ourgame.mahjong.libaray.data.CommonData;
	import com.ourgame.mahjong.libaray.enum.RoomType;
	import com.ourgame.mahjong.libaray.vo.ChatInfo;
	import com.ourgame.mahjong.libaray.vo.RoomInfo;
	import com.ourgame.mahjong.libaray.vo.TableInfo;
	import com.ourgame.mahjong.libaray.vo.socket.MJDataPack;
	import com.ourgame.mahjong.lobby.method.LobbyMethod;
	import com.ourgame.mahjong.main.method.SocketMethod;
	import com.ourgame.mahjong.main.model.MainSocketModel;
	import com.ourgame.mahjong.message.CReqEnterRoom;
	import com.ourgame.mahjong.message.CReqGlobalChat;
	import com.ourgame.mahjong.message.CReqLogin;
	import com.ourgame.mahjong.message.CReqLogout;
	import com.ourgame.mahjong.message.CReqRankList;
	import com.ourgame.mahjong.message.CReqRoomList;
	import com.ourgame.mahjong.message.CReqRoomPlayerAmount;
	import com.ourgame.mahjong.message.CReqUserAmount;
	import com.ourgame.mahjong.message.CReqUserData;
	import com.ourgame.mahjong.message.Room;
	import com.ourgame.mahjong.message.SAckEnterRoom;
	import com.ourgame.mahjong.message.SAckLogin;
	import com.ourgame.mahjong.message.SAckLogout;
	import com.ourgame.mahjong.message.SAckRoomList;
	import com.ourgame.mahjong.protocol.MJLobbyProtocol;
	import com.ourgame.mahjong.protocol.MJRoomProtocol;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.wecoit.data.ArrayList;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Application;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.core.INotice;
	import com.wecoit.utils.bytes.Base64;
	
	import flash.net.SharedObject;
	
	/**
	 * 大厅Socket控制器
	 * @author SiaoLeon
	 */
	public class LobbySocketController extends Controller
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
		public function LobbySocketController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(SocketMethod.RECIVED(MainSocketModel), RECIVED);
			
			this.register(LobbyMethod.LOGIN, LOGIN);
			this.register(LobbyMethod.LOGOUT, LOGOUT);
			
			this.register(LobbyMethod.UPDATE_RANK, UPDATE_RANK);
			this.register(LobbyMethod.UPDATE_USER, UPDATE_USER);
			this.register(LobbyMethod.UPDATE_USER_COUNT, UPDATE_USER_COUNT);
			this.register(LobbyMethod.SPEAKER, SPEAKER);
			
			this.register(RoomMethod.ROOM_LIST, ROOM_LIST);
			this.register(RoomMethod.ENTER_ROOM, ENTER_ROOM);
			this.register(RoomMethod.UPDATE_PLAYER_COUNT, UPDATE_PLAYER_COUNT);
			
			this.socket = this.context.getModel(MainSocketModel) as MainSocketModel;
		}
		
		override public function onRemove():void
		{
			this.socket = null;
		}
		
		// -------------------------------------------------------------------------------------------------------- 发送
		
		private function LOGIN(notice:INotice):void
		{
			var so:SharedObject = SharedObject.getLocal("OurgameMahjong");
			
			var body:CReqLogin = new CReqLogin();
			body.ourgameId = CommonData.ourgameID;
			body.username = CommonData.username;
			body.rolename = CommonData.rolename;
			body.nickname = CommonData.nickname;
			body.ticket = Base64.decode(CommonData.ticket);
			body.sessionKey = so.data["session"];
			body.headImage = CommonData.user.headImage;
			body.gender = CommonData.user.sex;
			body.channelId = CommonData.channelID;
			body.version = 1;
			body.force = true;
			body.antiAddict = (Application.stage.loaderInfo.parameters["CMStatus"] != 0);
			
			Log.debug("发送登录请求", body);
			
			this.socket.send(MJLobbyProtocol.CLIENT + MJLobbyProtocol.OGID_USER_LOGIN, body);
		}
		
		private function LOGOUT(notice:INotice):void
		{
			var so:SharedObject = SharedObject.getLocal("OurgameMahjong");
			
			var body:CReqLogout = new CReqLogout();
			body.sessionKey = so.data["session"];
			
			Log.debug("发送登出请求", body);
			
			this.socket.send(MJLobbyProtocol.CLIENT + MJLobbyProtocol.OGID_USER_LOGOUT, body);
		}
		
		private function UPDATE_RANK(notice:INotice):void
		{
			var body:CReqRankList = new CReqRankList();
			body.type = 0;
			body.page = 0;
			body.size = 20;
			
			Log.debug("发送更新排行榜请求", body);
			
			this.socket.send(MJLobbyProtocol.CLIENT + MJLobbyProtocol.OGID_RANK_DATA, body);
		}
		
		private function UPDATE_USER(notice:INotice):void
		{
			var body:CReqUserData = new CReqUserData();
			
			Log.debug("发送更新用户信息请求", body);
			
			this.socket.send(MJLobbyProtocol.CLIENT + MJLobbyProtocol.OGID_RANK_DATA, body);
		}
		
		private function UPDATE_USER_COUNT(notice:INotice):void
		{
			var body:CReqUserAmount = new CReqUserAmount();
			
			Log.debug("发送更新用户人数请求", body);
			
			this.socket.send(MJLobbyProtocol.CLIENT + MJLobbyProtocol.OGID_USER_COUNT, body);
		}
		
		private function SPEAKER(notice:INotice):void
		{
			var message:ChatInfo = notice.params;
			
			var body:CReqGlobalChat = new CReqGlobalChat();
			body.msgType = message.type;
			body.content = message.content;
			body.receivers = null;
			
			Log.debug("发送喇叭广播", message);
			
			this.socket.send(MJLobbyProtocol.CLIENT + MJLobbyProtocol.OGID_GLOBAL_CHAT, body);
		}
		
		private function ROOM_LIST(notice:INotice):void
		{
			var body:CReqRoomList = new CReqRoomList();
			
			Log.debug("发送获取房间列表请求", body);
			
			this.socket.send(MJRoomProtocol.CLIENT + MJRoomProtocol.OGID_ROOM_LIST, body);
		}
		
		private function ENTER_ROOM(notice:INotice):void
		{
			var body:CReqEnterRoom = new CReqEnterRoom();
			body.roomId = notice.params;
			
			Log.debug("发送进入房间请求", body);
			
			this.socket.send(MJRoomProtocol.CLIENT + MJRoomProtocol.OGID_ROOM_ENTER, body);
		}
		
		private function UPDATE_PLAYER_COUNT(notice:INotice):void
		{
			var body:CReqRoomPlayerAmount = new CReqRoomPlayerAmount();
			body.roomIds = notice.params;
			
			Log.debug("发送更新房间用户数请求", body);
			
			this.socket.send(MJRoomProtocol.CLIENT + MJRoomProtocol.OGID_PLAYER_COUNT, body);
		}
		
		// -------------------------------------------------------------------------------------------------------- 接收
		
		private function RECIVED(notice:INotice):void
		{
			var data:MJDataPack = notice.params;
			
			switch (data.type)
			{
				case MJLobbyProtocol.SERVER + MJLobbyProtocol.OGID_USER_LOGIN:
					this.ON_LOGIN(data);
					break;
				
				case MJLobbyProtocol.SERVER + MJLobbyProtocol.OGID_USER_LOGOUT:
					this.ON_LOGOUT(data);
					break;
				
				case MJLobbyProtocol.SERVER + MJLobbyProtocol.OGID_RANK_DATA:
					this.ON_RANK(data);
					break;
				
				case MJLobbyProtocol.SERVER + MJLobbyProtocol.OGID_USER_DATA:
					this.ON_USER(data);
					break;
				
				case MJLobbyProtocol.SERVER + MJLobbyProtocol.OGID_USER_COUNT:
					this.ON_USER_COUNT(data);
					break;
				
				case MJLobbyProtocol.SERVER + MJLobbyProtocol.OGID_GLOBAL_NOTICE:
					this.ON_NOTICE(data);
					break;
				
				case MJLobbyProtocol.SERVER + MJLobbyProtocol.OGID_GLOBAL_CHAT:
					this.ON_SPEAKER(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_ROOM_LIST:
					this.ON_ROOM_LIST(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_ROOM_ENTER:
					this.ON_ROOM_ENTER(data);
					break;
				
				case MJRoomProtocol.SERVER + MJRoomProtocol.OGID_PLAYER_COUNT:
					this.ON_PLAYER_COUNT(data);
					break;
			}
		}
		
		private function ON_LOGIN(data:MJDataPack):void
		{
			var body:SAckLogin = new SAckLogin();
			body.mergeFrom(data.body);
			
			Log.debug("请求登录结果", body);
			
			if (body.result == 0)
			{
				var so:SharedObject = SharedObject.getLocal("OurgameMahjong");
				so.data["session"] = body.sessionKey;
				so.flush();
				
				CommonData.user.nickname = CommonData.nickname;
				CommonData.user.id = body.userId.low;
				CommonData.user.coins = body.money;
				CommonData.user.experience = body.experience;
				CommonData.user.level = body.level;
				CommonData.user.masterScore = body.materScore;
				
				this.notify(LobbyMethod.LOGIN_SUCCESS);
			}
			else
			{
				Log.error("登录失败原因", body.failReason);
				this.notify(LobbyMethod.LOGIN_ERROR, body.result);
			}
		}
		
		private function ON_LOGOUT(data:MJDataPack):void
		{
			var body:SAckLogout = new SAckLogout();
			body.mergeFrom(data.body);
			
			Log.debug("请求登出结果", body);
			
			if (body.result == 0)
			{
				this.notify(LobbyMethod.LOGOUT_SUCCESS);
			}
			else
			{
				this.notify(LobbyMethod.LOGOUT_ERROR, body.result);
			}
		}
		
		private function ON_RANK(data:MJDataPack):void
		{
		}
		
		private function ON_USER(data:MJDataPack):void
		{
		}
		
		private function ON_USER_COUNT(data:MJDataPack):void
		{
		}
		
		private function ON_NOTICE(data:MJDataPack):void
		{
		}
		
		private function ON_SPEAKER(data:MJDataPack):void
		{
		}
		
		private function ON_ROOM_LIST(data:MJDataPack):void
		{
			var body:SAckRoomList = new SAckRoomList();
			body.mergeFrom(data.body);
			
			Log.debug("请求房间列表结果", body);
			
			CommonData.roomList = new ArrayList();
			
			for each (var room:Room in body.rooms)
			{
				var info:RoomInfo = new RoomInfo(room.roomId);
				info.name = room.roomName;
				info.type = room.roomType;
				info.gameType = room.gameType;
				info.playerCount = room.userAmount;
				info.buyin = room.enterBuyIn;
				info.rate = room.unitValue;
				CommonData.roomList.add(info);
				
				if (CommonData.room != null && CommonData.room.id == info.id)
				{
					CommonData.room = info;
				}
			}
			
			this.notify(RoomMethod.ROOM_LIST_SUCCESS);
		}
		
		private function ON_ROOM_ENTER(data:MJDataPack):void
		{
			var body:SAckEnterRoom = new SAckEnterRoom();
			body.mergeFrom(data.body);
			
			Log.debug("请求进入房间结果", body);
			
			if (body.result == 0)
			{
				CommonData.room = CommonData.getRoomByID(body.roomId);
				
				if (CommonData.room.type == RoomType.AUTO)
				{
					CommonData.user.seat = 0;
					CommonData.table = new TableInfo();
					CommonData.table.userList.add(CommonData.user);
				}
				
				this.notify(RoomMethod.ENTER_ROOM_SUCCESS);
			}
			else
			{
				Log.error("进入房间失败原因", body.failReason);
				
				this.notify(RoomMethod.ENTER_ROOM_ERROR, body.result);
			}
		}
		
		private function ON_PLAYER_COUNT(data:MJDataPack):void
		{
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
