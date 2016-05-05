package windows
{
	import configs.ConfigModel;
	import configs.TextureNameConst;
	
	import engine.MAssetManager;
	import engine.MImage;
	
	import screens.ScreenManager;
	import screens.gameScreen.GameScreen;
	import screens.gameScreen.GridModel;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFormat;

	public class ChoiseChipWindow extends SimpleWindow
	{
		private var _titleTf:TextField;
		private var _playWhiteButton:Button;
		private var _playBlackButton:Button;
		private var _blackChip:MImage;
		private var _whiteChip:MImage;
		
		public function ChoiseChipWindow()
		{
			super();
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			createTitle();
			createCoiseEnemyButtons();
			createChips();
			addListeners();
		}
		
		private function addListeners():void
		{
			_playWhiteButton.addEventListener(TouchEvent.TOUCH, onTouch);
			_playBlackButton.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function removeListeners():void
		{
			_playWhiteButton.removeEventListener(TouchEvent.TOUCH, onTouch);
			_playBlackButton.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function createChips():void
		{
			_blackChip = new MImage(TextureNameConst.CHIP);
			_blackChip.color = ConfigModel.chipBlackColor;
			addChild(_blackChip);
			_blackChip.x = _playBlackButton.x;
			_blackChip.y = _playBlackButton.y;
			
			_whiteChip = new MImage(TextureNameConst.CHIP);
			_whiteChip.color = ConfigModel.chipWhiteColor;
			addChild(_whiteChip);
			_whiteChip.x = _playWhiteButton.x;
			_whiteChip.y = _playWhiteButton.y;
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			var nameButton:String = (e.currentTarget as DisplayObject).name;
			if (touches.length == 0)
			{
			}
			
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					
				}
				
				if (touch.phase == TouchPhase.ENDED)
				{	
					if (nameButton == _playBlackButton.name) 
					{
						GridModel.computerColor = GridModel.WHITE;
					}
					if (nameButton == _playWhiteButton.name) 
					{
						GridModel.computerColor = GridModel.BLACK;
					}
					
					WindowsManager.hide(function():void{ScreenManager.show(GameScreen)});
				}
				
				if (touch.phase == TouchPhase.HOVER)
				{
					
				}
			}
		}
		
		private function createCoiseEnemyButtons():void
		{
			_playBlackButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_SHOISE), ConfigModel.playBlackBtnText);
			_playBlackButton.name = "Play Black";
			_playBlackButton.textFormat = new TextFormat(ConfigModel.playBlackBtnFont, ConfigModel.playBlackBtnSize);
			addChild(_playBlackButton);
			
			_playBlackButton.x = (this.width - _playBlackButton.width) >> 1;
			_playBlackButton.y = (this.height - _playBlackButton.height) >> 1;
			
			_playWhiteButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_SHOISE), ConfigModel.playWhiteBtnText);
			_playWhiteButton.name = "Play White";
			_playWhiteButton.textFormat = new TextFormat(ConfigModel.playWhiteBtnFont, ConfigModel.playWhiteBtnSize);
			addChild(_playWhiteButton);
			
			_playWhiteButton.x = (this.width - _playWhiteButton.width) >> 1;
			_playWhiteButton.y = _playBlackButton.y + _playWhiteButton.height;
		}
		
		private function createTitle():void
		{
			var tfFormat:TextFormat = new TextFormat(ConfigModel.choiseChipWindowTitleTfFont, ConfigModel.choiseChipWindowTitleTfSize);
			
			_titleTf = new TextField(ConfigModel.choiseChipWindowTitleTfWidth, ConfigModel.choiseChipWindowTitleTfHeight, ConfigModel.choiseChipWindowTitleTfText, tfFormat);
			addChild(_titleTf);
			_titleTf.x = (this.width - _titleTf.width) >> 1;
			_titleTf.y = _titleTf.height >> 1;
		}
		
		override protected function destroy(e:Event):void
		{
			removeListeners();
			super.destroy(e);
		}
	}
}