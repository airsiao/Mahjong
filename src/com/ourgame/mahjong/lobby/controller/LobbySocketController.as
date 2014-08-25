package com.ourgame.mahjong.lobby.controller
{
	import com.ourgame.mahjong.Main;
	import com.ourgame.mahjong.libaray.DataExchange;
	import com.ourgame.mahjong.libaray.enum.GameType;
	import com.ourgame.mahjong.libaray.enum.RoomType;
	import com.ourgame.mahjong.libaray.vo.ChatInfo;
	import com.ourgame.mahjong.libaray.vo.RoomInfo;
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
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Application;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.State;
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
		
		private var data:DataExchange;
		
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
			
			this.data = ((this.context as State).manager as Main).info.data;
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
			body.ourgameId = this.data.ourgameID;
			body.username = this.data.username;
			body.rolename = this.data.rolename;
			body.nickname = this.data.nickname;
			body.ticket = Base64.decode(this.data.ticket);
			body.sessionKey = so.data["session"];
			body.headImage = this.data.user.headImage;
			body.gender = this.data.user.sex;
			body.channelId = this.data.channelID;
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
			//TODO
			this.data.user.nickname = "AAAA";
			this.data.user.id = 1;
			this.data.user.coins = 1000000;
			this.data.user.experience = 0;
			this.data.user.level = 0;
			this.data.user.masterScore = 100;
			
			this.notify(LobbyMethod.LOGIN_SUCCESS);
			
			return;
			
			var body:SAckLogin = new SAckLogin();
			body.mergeFrom(data.body);
			
			Log.debug("请求登录结果", body);
			
			if (body.result == 0)
			{
				var so:SharedObject = SharedObject.getLocal("OurgameMahjong");
				so.data["session"] = body.sessionKey;
				so.flush();
				
				this.data.user.nickname = this.data.nickname;
				this.data.user.id = body.userId.low;
				this.data.user.coins = body.money;
				this.data.user.experience = body.experience;
				this.data.user.level = body.level;
				this.data.user.masterScore = body.materScore;
				
				this.notify(LobbyMethod.LOGIN_SUCCESS);
			}
			else
			{
				Log.debug("登录失败原因", body.failReason);
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
			//TODO
			this.data.roomList.clear();
			
			var r:RoomInfo = new RoomInfo(5);
			r.name = "A";
			r.gameType = GameType.BloodRiver;
			
			this.data.roomList.add(r);
			
			this.notify(RoomMethod.ROOM_LIST_SUCCESS);
			
			this.notify(RoomMethod.ENTER_ROOM, 5);
			
			return;
			
			var body:SAckRoomList = new SAckRoomList();
			body.mergeFrom(data.body);
			
			Log.debug("请求房间列表结果", body);
			
			this.data.roomList.clear();
			
			while (body.rooms.length > 0)
			{
				var room:Room = body.rooms.shift();
				var info:RoomInfo = new RoomInfo(room.roomId);
				info.name = room.roomName;
				info.type = room.roomType;
				info.gameType = room.gameType;
				info.playerCount = room.userAmount;
				info.buyin = room.enterBuyIn;
				info.rate = room.unitValue;
				this.data.roomList.add(info);
				
				if (this.data.room != null && this.data.room.id == info.id)
				{
					this.data.room = info;
				}
			}
			
			this.notify(RoomMethod.ROOM_LIST_SUCCESS);
		}
		
		private function ON_ROOM_ENTER(data:MJDataPack):void
		{
			//TODO
			this.data.room = this.data.getRoomByID(5);
			this.data.room.type = RoomType.AUTO;
			this.notify(RoomMethod.ENTER_ROOM_SUCCESS);
			
			return;
			
			var body:SAckEnterRoom = new SAckEnterRoom();
			body.mergeFrom(data.body);
			
			Log.debug("请求进入房间结果", body);
			
			if (body.result == 0)
			{
				this.data.room = this.data.getRoomByID(body.roomId);
				this.notify(RoomMethod.ENTER_ROOM_SUCCESS);
			}
			else
			{
				this.notify(RoomMethod.ENTER_ROOM_ERROR, body.result);
			}
		}
		
		private function ON_PLAYER_COUNT(data:MJDataPack):void
		{
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
