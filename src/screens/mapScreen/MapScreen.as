package screens.mapScreen
{
	import configs.ConfigModel;
	import configs.TextureNameConst;
	
	import engine.MAssetManager;
	import engine.MImage;
	import engine.MSprite;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextFormat;
	
	import windows.StartGameWindow;
	import windows.WindowsManager;
	
	public class MapScreen extends MSprite
	{
		private var _startGameButton:Button;
		private var _mapBackground:MImage;
		
		public function MapScreen()
		{
			super();
		}
		
		override protected function init(e:Event = null):void
		{
			super.init();
			
			createBackground();
			createStartGameButton();
			
			addListeners();
			onResize();
		}
		
		private function addListeners():void
		{
			stage.addEventListener(Event.RESIZE, onResize);
			_startGameButton.addEventListener(TouchEvent.TOUCH, onTouchStartGameButton);
		}
		
		private function removeListeners():void
		{
			_startGameButton.removeEventListener(TouchEvent.TOUCH, onTouchStartGameButton);
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		private function onTouchStartGameButton(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			
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
					WindowsManager.show(StartGameWindow);
				}
				
				if (touch.phase == TouchPhase.HOVER)
				{
				}
			}
		}
		
		private function createStartGameButton():void
		{
			_startGameButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_START), ConfigModel.startGameBtnText);
			_startGameButton.textFormat = new TextFormat(ConfigModel.startGameBtnFont, ConfigModel.startGameBtnSize);
			addChild(_startGameButton);
			_startGameButton.x = (_mapBackground.width - _startGameButton.width) >> 1;
			_startGameButton.y = (_mapBackground.height - _startGameButton.height) >> 1;
		}

		private function createBackground():void
		{
			_mapBackground = new MImage(TextureNameConst.MAP_SCREEN_BG);
			addChild(_mapBackground);
		}
		
		override protected function onResize(e:Event = null):void
		{
			_mapBackground.width = stage.stageWidth;
			_mapBackground.height = stage.stageHeight;
			
			_startGameButton.x = (stage.stageWidth - _startGameButton.width >> 1);
			_startGameButton.y = (stage.stageHeight - _startGameButton.height) >> 1;
		}
		
		override protected function destroy(e:Event):void
		{
			removeListeners();
			super.destroy(e);
		}
	}
}