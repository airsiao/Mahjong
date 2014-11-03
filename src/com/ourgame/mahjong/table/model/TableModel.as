package com.ourgame.mahjong.table.model
{
	import com.ourgame.mahjong.libaray.ITableProxy;
	import com.ourgame.mahjong.libaray.data.CommonData;
	import com.ourgame.mahjong.libaray.enum.RoomType;
	import com.ourgame.mahjong.room.method.RoomMethod;
	import com.wecoit.mvc.Model;
	
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
			CommonData.tableProxy = this;
		}
		
		override public function onRemove():void
		{
			CommonData.tableProxy = null;
		}
		
		public function ready():void
		{
			this.notify(RoomMethod.STAND_BY);
		}
		
		public function leave():void
		{
			if (CommonData.room.type == RoomType.AUTO)
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
