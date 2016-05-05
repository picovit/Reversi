package grids
{
	import com.greensock.TweenMax;
	
	import flash.geom.Point;
	
	import configs.ConfigModel;
	import configs.TextureNameConst;
	
	import engine.MImage;
	import engine.MSprite;
	
	import starling.display.Quad;
	import starling.events.Event;

	public class GridCell extends MSprite
	{
		private var background:MImage;
		private var possible:Quad;
		private var chip:Chip;
		
		private var _position:Point;
		
		public function GridCell(i:uint, j:uint)
		{
			_position = new Point(i, j);
		}

		public function get position():Point
		{
			return _position;
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			createBackground();
		}
		
		public function animateChip(color:Boolean):void
		{
			chip.animateTurn(color);
		}
		
		public function addAnimateCell():void
		{
			possible = new Quad(background.width, background.height, ConfigModel.cellPossibleColor);//in config
			addChild(possible);
			
			TweenMax.from(possible, ConfigModel.cellPossibleTimeAnimation, {alpha:ConfigModel.cellPossibleAlphaAnimation, ease:ConfigModel.cellPossibleEaseAnimation, repeat:-1, yoyo:true});//in config
		}
		
		public function removeAnimateCell():void
		{
			possible.visible = false;
		}
		
		public function createChip(color:Boolean):void
		{
			chip = new Chip(color, this.width);
			addChild(chip);
			chip.alignPivot();
			chip.x = background.width >> 1;
			chip.y = background.height >> 1;
			
			createChipAnimation();
		}
		
		private function createChipAnimation():void
		{
			TweenMax.fromTo(chip, ConfigModel.chipCreateTimeAnimation, {scale:ConfigModel.chipCreateFromVarsAnimation}, {scale:ConfigModel.chipCreateToVarsAnimation});//in config
		}
		
		private function createBackground():void
		{
			background = new MImage(TextureNameConst.CELL);
			background.width = background.height = ConfigModel.cellSize;//in config
			background.alpha = ConfigModel.cellAlpha;//in config
			background.color = ConfigModel.cellColor;//in config
			addChild(background);
		}
	}
}