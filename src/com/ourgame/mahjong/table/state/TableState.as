package com.ourgame.mahjong.table.state
{
	import com.ourgame.mahjong.table.controller.TableController;
	import com.ourgame.mahjong.table.controller.TableSocketController;
	import com.ourgame.mahjong.table.model.TableModel;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.State;
	
	/**
	 * 桌子状态
	 * @author SiaoLeon
	 */
	public class TableState extends State
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
		public function TableState(key:Object=null)
		{
			super(key);
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		override public function onEnter():void
		{
			Log.info("进入桌子状态");
			
			this.addModel(TableModel);
			
			this.addController(new TableController());
			this.addController(new TableSocketController());
		}
	
		// -------------------------------------------------------------------------------------------------------- 函数
	
	}
}
