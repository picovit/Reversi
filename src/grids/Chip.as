package grids
{
	import com.greensock.TweenMax;
	
	import configs.ConfigModel;
	import configs.TextureNameConst;
	
	import engine.MImage;
	import engine.MSprite;

	public class Chip extends MSprite
	{
		private var _blackChip:MImage;
		private var _whiteChip:MImage;
		private var _color:Boolean;
		private var _gridCellWidth:Number;
		
		public function Chip(color:Boolean, gridCellWidth:Number)
		{
			super();
			_gridCellWidth = gridCellWidth;
			drawChip();
			this.color = color;
		}
		
		public function get color():Boolean
		{
			return _color;
		}

		public function set color(value:Boolean):void
		{			
			if (value) 
			{
				_whiteChip.visible = true;
			}
			else
			{
				_blackChip.visible = true;
			}
			_color = value;
		}

		private function drawChip():void
		{
			_blackChip = new MImage(TextureNameConst.CHIP);
			_blackChip.color = ConfigModel.chipBlackColor;
			addChild(_blackChip);
			_blackChip.alignPivot();
			if (ConfigModel.chipSize <= _gridCellWidth) 
			{
				_blackChip.width = _blackChip.height = ConfigModel.chipSize;
			}
			else
			{
				_blackChip.width = _blackChip.height =  _gridCellWidth;
			}
			_blackChip.visible = false;
			
			_whiteChip = new MImage(TextureNameConst.CHIP);
			_whiteChip.color = ConfigModel.chipWhiteColor;
			addChild(_whiteChip);
			_whiteChip.alignPivot();
			
			if (ConfigModel.chipSize <= _gridCellWidth) 
			{
				_whiteChip.width = _whiteChip.height = ConfigModel.chipSize;
			}
			else
			{
				_whiteChip.width = _whiteChip.height =  _gridCellWidth;
			}
			
			_whiteChip.visible = false;
		}
		
		public function animateTurn(color:Boolean):void
		{
			if (color) 
			{
				playAnimate(_blackChip, _whiteChip);
			}
			else
			{
				playAnimate(_whiteChip, _blackChip);
			}
		}
		
		private function playAnimate(chipFrom:MImage, chipTo:MImage):void
		{
			TweenMax.to(chipFrom, ConfigModel.chipTurnTimeAnimation, {width:0, visible:false, ease:ConfigModel.chipTurnEaseAnimation, onComplete:onCompleteFrom});
			
			function onCompleteFrom():void
			{
				chipTo.visible = true;
				TweenMax.fromTo(chipTo, ConfigModel.chipTurnTimeAnimation, {width:0}, {width:ConfigModel.chipSize});
			}
		}
	}
}