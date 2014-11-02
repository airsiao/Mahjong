package com.ourgame.mahjong.main.uitls
{
	/**
	 * 把阿拉伯数字单位转换成中文大写，如：一二三
	 * @param num 阿拉伯数字
	 * @return 中文大写
	 */
	public function currency(value:uint):String
	{
		if ((value / 100000000) >= 1)
		{
			return Math.floor(value / 1000000) / 100 + "亿";
		}
		
		if ((value / 10000) >= 1)
		{
			return Math.floor(value / 100) / 100 + "万";
		}
		
		return String(value);
	}

}
