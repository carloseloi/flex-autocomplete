package com.hillelcoren.assets.skins
{
	import flash.display.Graphics;  
	import mx.skins.ProgrammaticSkin;

	public class MacMailButtonSkin extends ProgrammaticSkin 
	{
		private static const RADIUS:int = 20;
		
		public var color:uint;
		public var borderColor:uint;
		
		public function MacMailButtonSkin() 
		{
			color		= 0xDEE7FB;
			borderColor = 0xA4BDEC; 
		}

		override protected function updateDisplayList( w:Number, h:Number ):void 
		{	
			switch (name) 
			{
				case "upSkin":
					color = 0xDEE7FB;
					break;
				case "overSkin":
					color = 0xBBCEF1;
					break;
				case "downSkin":
				case "selectedUpSkin":
				case "selectedOverSkin":
				case "selectedDownSkin":
					color = 0x598BEC;
			}
			
			var g:Graphics = graphics;
			g.clear();
			g.beginFill( color );
			g.lineStyle( 1, borderColor );
			g.drawRoundRect( 0, 1, w, h-2, RADIUS );
			g.endFill();
		}
	}
}