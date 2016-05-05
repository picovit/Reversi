package windows
{
	import configs.ConfigModel;
	import configs.TextureNameConst;
	
	import engine.MAssetManager;
	
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

	public class StartGameWindow extends SimpleWindow
	{
		private var _titleTf:TextField;
		private var _singlePlayerButton:Button;
		private var _twoPlayerButton:Button;
		
		public function StartGameWindow()
		{
			super();
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			createTitle();
			createCoiseEnemyButtons();
			addListeners();
		}
		
		private function addListeners():void
		{
			_singlePlayerButton.addEventListener(TouchEvent.TOUCH, onTouch);
			_twoPlayerButton.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function removeListeners():void
		{
			_singlePlayerButton.removeEventListener(TouchEvent.TOUCH, onTouch);
			_twoPlayerButton.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			var button:Button = (e.currentTarget as Button);
			
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
					switch(button.name)
					{
						case _singlePlayerButton.name:
						{
							GridModel.playerMode = GridModel.singlePlayerMode;
							WindowsManager.hide(function():void{WindowsManager.show(ChoiseChipWindow)});
							break;
						}
							
						case _twoPlayerButton.name:
						{
							GridModel.playerMode = GridModel.twoPlayerModel;
							WindowsManager.hide(function():void{ScreenManager.show(GameScreen)});
							break;
						}
					}
				}
				
				if (touch.phase == TouchPhase.HOVER)
				{
					
				}
			}
		}
		
		private function createCoiseEnemyButtons():void
		{
			_singlePlayerButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_SHOISE), ConfigModel.singlePlayerBtnText);
			_singlePlayerButton.name = "Single";
			_singlePlayerButton.textFormat = new TextFormat(ConfigModel.singlePlayerBtnFont, ConfigModel.singlePlayerBtnSize);
			addChild(_singlePlayerButton);
			
			_singlePlayerButton.x = (this.width - _singlePlayerButton.width) >> 1;
			_singlePlayerButton.y = (this.height - _singlePlayerButton.height) >> 1;
			
			_twoPlayerButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_SHOISE), ConfigModel.twoPlayerBtnText);
			_singlePlayerButton.name = "Two";
			_twoPlayerButton.textFormat = new TextFormat(ConfigModel.twoPlayerBtnFont, ConfigModel.twoPlayerBtnSize);
			addChild(_twoPlayerButton);
			
			_twoPlayerButton.x = (this.width - _twoPlayerButton.width) >> 1;
			_twoPlayerButton.y = _singlePlayerButton.y + _twoPlayerButton.height;
		}
		
		private function createTitle():void
		{
			var tfFormat:TextFormat = new TextFormat(ConfigModel.startGameWindowTitleTfFont, ConfigModel.startGameWindowTitleTfSize);
			
			_titleTf = new TextField(ConfigModel.startGameWindowTitleTfWidth, ConfigModel.startGameWindowTitleTfHeight, ConfigModel.startGameWindowTitleTfText, tfFormat);
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