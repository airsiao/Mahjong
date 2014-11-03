package com.ourgame.mahjong.main.controller
{
	import com.ourgame.mahjong.libaray.data.CommonData;
	import com.ourgame.mahjong.libaray.enum.RoomType;
	import com.ourgame.mahjong.libaray.vo.GameInfo;
	import com.ourgame.mahjong.libaray.vo.RoomInfo;
	import com.ourgame.mahjong.lobby.method.LobbyMethod;
	import com.ourgame.mahjong.lobby.state.LobbyState;
	import com.ourgame.mahjong.main.method.MainMethod;
	import com.ourgame.mahjong.main.method.SocketMethod;
	import com.ourgame.mahjong.main.model.MainSocketModel;
	import com.ourgame.mahjong.main.model.UserModel;
	import com.ourgame.mahjong.main.state.MainState;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.ourgame.mahjong.room.state.RoomManualState;
	import com.ourgame.mahjong.table.state.TableState;
	import com.wecoit.mvc.Controller;
	import com.wecoit.mvc.State;
	import com.wecoit.mvc.core.INotice;
	
	/**
	 * 主程序控制器
	 * @author SiaoLeon
	 */
	public class MainController extends Controller
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
		public function MainController()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.register(MainMethod.LOAD_USERINFO_ERROR, LOAD_USERINFO_ERROR);
			this.register(MainMethod.LOAD_USERINFO_COMPLETE, LOAD_USERINFO_COMPLETE);
			
			this.register(SocketMethod.CONNECT_ERROR(MainSocketModel), CONNECT_ERROR);
			this.register(SocketMethod.CONNECT_SUCCESS(MainSocketModel), CONNECT_SUCCESS);
			
			this.register(MainMethod.LOAD_GAME_ERROR, LOAD_GAME_ERROR);
			this.register(MainMethod.LOAD_GAME_COMPLETE, LOAD_GAME_COMPLETE);
			
			this.register(RoomMethod.ENTER_ROOM_ERROR, ENTER_ROOM_ERROR);
			this.register(RoomMethod.ENTER_ROOM_SUCCESS, ENTER_ROOM_SUCCESS);
			this.register(RoomMethod.LEAVE_ROOM_ERROR, LEAVE_ROOM_ERROR);
			this.register(RoomMethod.LEAVE_ROOM_SUCCESS, LEAVE_ROOM_SUCCESS);
			
			this.register(RoomMethod.ENTER_TABLE_ERROR, ENTER_TABLE_ERROR);
			this.register(RoomMethod.ENTER_TABLE_SUCCESS, ENTER_TABLE_SUCCESS);
			this.register(RoomMethod.LEAVE_TABLE_ERROR, LEAVE_TABLE_ERROR);
			this.register(RoomMethod.LEAVE_TABLE_SUCCESS, LEAVE_TABLE_SUCCESS);
			
			(this.context.getModel(UserModel) as UserModel).load();
		}
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		private function LOAD_USERINFO_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function LOAD_USERINFO_COMPLETE(notice:INotice):void
		{
			this.notify(SocketMethod.CONNECT(MainSocketModel));
		}
		
		private function CONNECT_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function CONNECT_SUCCESS(notice:INotice):void
		{
			(this.context as State).manager.switchState(LobbyState);
			
			this.notify(LobbyMethod.LOGIN);
		}
		
		private function LOAD_GAME_ERROR(notice:INotice):void
		{
			if (CommonData.room.type == RoomType.AUTO)
			{
				CommonData.room = null;
			}
		}
		
		private function LOAD_GAME_COMPLETE(notice:INotice):void
		{
			var game:GameInfo = notice.params;
			
			if (game.main.hasOwnProperty("info"))
			{
				game.main["info"] = game;
			}
			
			(this.context as MainState).view.play(game);
			
			(this.context as State).manager.switchState(TableState);
		}
		
		private function ENTER_ROOM_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ENTER_ROOM_SUCCESS(notice:INotice):void
		{
			var room:RoomInfo = CommonData.room;
			
			if (room.type == RoomType.AUTO)
			{
				this.notify(MainMethod.LOAD_GAME, room.gameType);
			}
			else
			{
				(this.context as State).manager.switchState(RoomManualState);
			}
		}
		
		private function LEAVE_ROOM_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function LEAVE_ROOM_SUCCESS(notice:INotice):void
		{
			var room:RoomInfo = notice.params;
			
			(this.context as State).manager.switchState(LobbyState);
			
			if (room.type == RoomType.AUTO)
			{
				(this.context as MainState).view.stop();
				
				this.notify(RoomMethod.ROOM_LIST);
			}
			else
			{
			}
		}
		
		private function ENTER_TABLE_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function ENTER_TABLE_SUCCESS(notice:INotice):void
		{
			if (CommonData.room.type == RoomType.MANUAL)
			{
				this.notify(MainMethod.LOAD_GAME, CommonData.room.gameType);
			}
		}
		
		private function LEAVE_TABLE_ERROR(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
		
		private function LEAVE_TABLE_SUCCESS(notice:INotice):void
		{
			// TODO Auto Generated method stub
		
		}
	
	}
}
