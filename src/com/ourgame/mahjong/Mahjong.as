package com.ourgame.mahjong
{
	import com.ourgame.mahjong.state.MainState;
	import com.wecoit.debug.Log;
	import com.wecoit.mvc.Application;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Security;
	import flash.ui.Keyboard;
	
	[SWF(width="960", height="685", backgroundColor="#000000", frameRate="24")]
	
	/**
	 * 麻将启动程序
	 * @author SiaoLeon
	 */
	public class Mahjong extends Application
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
		public function Mahjong()
		{
			super(new MainState());
			
			Security.allowDomain("*");
		}
		
		// -------------------------------------------------------------------------------------------------------- 方法
		
		// -------------------------------------------------------------------------------------------------------- 函数
		
		override protected function onAddedToStage():void
		{
			super.onAddedToStage();
			
			Application.stage.scaleMode = StageScaleMode.NO_SCALE;
			Application.stage.align = StageAlign.TOP_LEFT;
			
			Log.instance.listen(this.stage, Keyboard.END, true, true);
		}
	
	}
}
