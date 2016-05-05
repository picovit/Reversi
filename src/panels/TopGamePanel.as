package panels
{
	import configs.ConfigModel;
	import configs.TextureNameConst;
	
	import engine.MImage;
	import engine.MSprite;
	
	import grids.Chip;
	import grids.GridEvents;
	
	import screens.gameScreen.GridModel;
	
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFormat;

	public class TopGamePanel extends MSprite
	{
		private var _model:GridModel;
		private var _currentChip:MImage;
		private var _colorBackground:Number;
		private var _chip:Chip;
		private var _turn:Boolean;
		private var blackScoreTf:TextField;
		private var whiteScoreTf:TextField;
		private var _blackChip:MImage;
		private var _whiteChip:MImage;
		
		public function TopGamePanel(model:GridModel)
		{
			super();
			_model = model;
		}
		
		private function addListeners():void
		{
			_model.addEventListener(GridEvents.CHANGE_TURN, changeChip);
			_model.addEventListener(GridEvents.CHANGE_BLACK_SCORE, changeBlackScore);
			_model.addEventListener(GridEvents.CHANGE_WHITE_SCORE, changeWhiteScore);
		}
		
		private function removeListeners():void
		{
			_model.removeEventListener(GridEvents.CHANGE_TURN, changeChip);
			_model.removeEventListener(GridEvents.CHANGE_BLACK_SCORE, changeBlackScore);
			_model.removeEventListener(GridEvents.CHANGE_WHITE_SCORE, changeWhiteScore);
		}
		
		private function changeWhiteScore(e:Event):void
		{
			whiteScoreTf.text = String(e.data);
		}
		
		private function changeBlackScore(e:Event):void
		{
			blackScoreTf.text = String(e.data);
		}

		private function changeChip(e:Event):void
		{
			var turn:Boolean = Boolean(e.data);
			_chip.animateTurn(turn);
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			addListeners();
			var whiteChipSubstrae:MImage = new MImage(TextureNameConst.CHIP_SUBSTRATE);
			addChild(whiteChipSubstrae);
			
			_whiteChip = new MImage(TextureNameConst.CHIP);
			_whiteChip.color = ConfigModel.chipWhiteColor;
			_whiteChip.alignPivot();
			addChild(_whiteChip);
			_whiteChip.x = whiteChipSubstrae.width >> 1;
			_whiteChip.y = whiteChipSubstrae.y + (whiteChipSubstrae.height >> 1);
			
			var whiteScoreSubstrae:MImage = new MImage(TextureNameConst.SCORE_SUBSTRATE);
			addChild(whiteScoreSubstrae);
			whiteScoreSubstrae.x = whiteChipSubstrae.width;
			
			var blackChipSubstrate:MImage = new MImage(TextureNameConst.CHIP_SUBSTRATE);
			addChild(blackChipSubstrate);
			blackChipSubstrate.x = 400;
			
			_blackChip = new MImage(TextureNameConst.CHIP);
			_blackChip.color = ConfigModel.chipBlackColor;
			_blackChip.alignPivot();
			addChild(_blackChip);
			
			_blackChip.x = blackChipSubstrate.x + (blackChipSubstrate.width >> 1);
			_blackChip.y = blackChipSubstrate.y + (blackChipSubstrate.height >> 1);
			
			var blackScoreSubstrae:MImage = new MImage(TextureNameConst.SCORE_SUBSTRATE);
			addChild(blackScoreSubstrae);
			blackScoreSubstrae.x = blackChipSubstrate.x - blackScoreSubstrae.width;
			
			_currentChip = new MImage(TextureNameConst.CURRENT_TURN_SUBSTRATE);
			addChild(_currentChip);
			_currentChip.x = (this.width - _currentChip.width)  >> 1;
			
			_chip = new Chip(_model.turn, this.width);
			addChild(_chip);
			_chip.alignPivot();
			_chip.x = _currentChip.x + (_currentChip.width >> 1);
			_chip.y = _currentChip.y + (_currentChip.height >> 1);
			
			var tfFormat:TextFormat = new TextFormat(ConfigModel.scoreTfFont, ConfigModel.scoreTfSize);
			
			whiteScoreTf = new TextField(ConfigModel.scoreTfWidth, ConfigModel.scoreTfHeight, _model.whiteScore.toString(), tfFormat);
			addChild(whiteScoreTf);
			whiteScoreTf.alignPivot();
			whiteScoreTf.x = whiteScoreSubstrae.x + (whiteScoreSubstrae.width >> 1);
			whiteScoreTf.y = whiteScoreSubstrae.y + (whiteScoreSubstrae.height >> 1);
			
			blackScoreTf = new TextField(ConfigModel.scoreTfWidth, ConfigModel.scoreTfHeight, _model.blackScore.toString(), tfFormat);
			addChild(blackScoreTf);
			blackScoreTf.alignPivot();
			blackScoreTf.x = blackScoreSubstrae.x + (blackScoreSubstrae.width >> 1);
			blackScoreTf.y = blackScoreSubstrae.y + (blackScoreSubstrae.height >> 1);
		}
		
		override protected function onResize(e:Event = null):void
		{
			
		}
		
		override protected function destroy(e:Event):void
		{
			removeListeners();
			super.destroy(e);
		}
	}
}