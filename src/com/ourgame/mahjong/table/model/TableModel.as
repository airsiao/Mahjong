package com.ourgame.mahjong.table.model
{
	import com.ourgame.mahjong.Main;
	import com.ourgame.mahjong.libaray.DataExchange;
	import com.ourgame.mahjong.libaray.ITableProxy;
	import com.ourgame.mahjong.libaray.enum.RoomType;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.wecoit.mvc.Model;
	import com.wecoit.mvc.State;
	
	/**
	 * 桌子数据模型
	 * @author SiaoLeon
	 */
	public class TableModel extends Model implements ITableProxy
	{
		// -------------------------------------------------------------------------------------------------------- 静态常量
		
		// -------------------------------------------------------------------------------------------------------- 静态变量
		
		// -------------------------------------------------------------------------------------------------------- 静态方法
		
		// -------------------------------------------------------------------------------------------------------- 静态函数
		
		// -------------------------------------------------------------------------------------------------------- 属性
		
		// -------------------------------------------------------------------------------------------------------- 变量
		
		private var data:DataExchange;
		
		// -------------------------------------------------------------------------------------------------------- 构造
		
		/**
		 * 构造函数
		 */
		public function TableModel()
		{
			super();
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onAdd():void
		{
			this.data = ((this.context as State).manager as Main).info.data;
			this.data.tableProxy = this;
		}
		
		override public function onRemove():void
		{
			this.data.tableProxy = null;
			this.data = null;
		}
		
		public function ready():void
		{
			this.notify(RoomMethod.STAND_BY);
		}
		
		public function leave():void
		{
			if (((this.context as State).manager as Main).info.data.room.type == RoomType.AUTO)
			{
				this.notify(RoomMethod.LEAVE_ROOM);
			}
			else
			{
				this.notify(RoomMethod.LEAVE_TABLE);
			}
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
