package screens.gameScreen
{
	import configs.ConfigModel;
	import configs.TextureNameConst;
	
	import engine.MAssetManager;
	import engine.MImage;
	import engine.MSprite;
	
	import panels.TopGamePanel;
	
	import screens.ScreenManager;
	import screens.mapScreen.MapScreen;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextFormat;
	
	import windows.WindowsManager;

	public class GameScreen extends MSprite
	{
		private var _gridView:GridView;
		private var background:MImage;
		private var _topGamePanel:TopGamePanel;
		private var _gridModel:GridModel;
		private var _controller:Controller;
		private var _rePlayButton:Button;
		private var _toMapButton:Button;
		
		public function GameScreen()
		{
			super();
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			startGame();
			createRePlayBtn();
			createToMapBtn();
			onResize();
			addListeners();
		}
		
		private function createToMapBtn():void
		{
			_toMapButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_SHOISE), ConfigModel.toMapBtnText);
			_toMapButton.name = "ToMap";
			_toMapButton.textFormat = new TextFormat(ConfigModel.toMapBtnFont, ConfigModel.toMapBtnSize);
			addChild(_toMapButton);
			_toMapButton.y = stage.stageHeight - _toMapButton.height;
		}
		
		private function createRePlayBtn():void
		{
			_rePlayButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_SHOISE), ConfigModel.rePlayBtnText);
			_rePlayButton.name = "Replay";
			_rePlayButton.textFormat = new TextFormat(ConfigModel.rePlayBtnFont, ConfigModel.rePlayBtnSize);
			addChild(_rePlayButton);
			_rePlayButton.y = stage.stageHeight - _rePlayButton.height;
			_rePlayButton.x = stage.stageWidth - _rePlayButton.width;
		}
		
		private function addListeners():void
		{
			stage.addEventListener(Event.RESIZE, onResize);
			_toMapButton.addEventListener(TouchEvent.TOUCH, onTouchButtons);
			_rePlayButton.addEventListener(TouchEvent.TOUCH, onTouchButtons);
		}
		
		private function removeListeners():void
		{
			stage.removeEventListener(Event.RESIZE, onResize);
			_toMapButton.removeEventListener(TouchEvent.TOUCH, onTouchButtons);
			_rePlayButton.removeEventListener(TouchEvent.TOUCH, onTouchButtons);
		}
		
		private function onTouchButtons(e:TouchEvent):void
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
					if (button.name == _toMapButton.name) 
					{
						WindowsManager.hide(function():void{ScreenManager.show(MapScreen)});
					}
					if (button.name == _rePlayButton.name) 
					{
						WindowsManager.hide(function():void{ScreenManager.show(GameScreen)});
					}
				}
				
				if (touch.phase == TouchPhase.HOVER)
				{
					
				}
			}
		}
		
		override protected function onResize(e:Event = null):void
		{
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			
			_gridView.x = (stage.stageWidth - _gridView.width >> 1);
			_gridView.y = (stage.stageHeight - _gridView.height) >> 1;
//			
			_topGamePanel.x = stage.stageWidth >> 1;
			
			_toMapButton.y = stage.stageHeight - _toMapButton.height;
			
			_rePlayButton.y = stage.stageHeight - _rePlayButton.height;
			_rePlayButton.x = stage.stageWidth - _rePlayButton.width;
		}
		
		private function startGame():void
		{
			background = new MImage(TextureNameConst.GAME_SCREEN_BG);
			addChild(background);
			
			_gridModel = new GridModel();
			_controller = new Controller(_gridModel);
			_gridView = new GridView(_gridModel, _controller, this.stage);
			addChild(_gridView);
			_gridView.x = (stage.stageWidth - _gridView.width >> 1);
			_gridView.y = (stage.stageHeight - _gridView.height) >> 1;
			
			_topGamePanel = new TopGamePanel(_gridModel);
			addChild(_topGamePanel);
			_topGamePanel.alignPivot();
			_topGamePanel.x = stage.stageWidth >> 1;
			_topGamePanel.y = _topGamePanel.height >> 1;
		}
		
		override protected function destroy(e:Event):void
		{
			removeListeners();
			_gridModel.destroyModel();
			super.destroy(e);
		}
	}
}