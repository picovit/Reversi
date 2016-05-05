package windows
{
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

	public class SimpleWindow extends MSprite
	{
		private var _clsoeButton:Button;
		private var _background:MImage;

		public function SimpleWindow()
		{
			
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			
			createBackground();
			createCloseButton();
			this.alignPivot();
			addListeners();
		}
		
		private function addListeners():void
		{
			_clsoeButton.addEventListener(TouchEvent.TOUCH, onTouchCloseButton);
		}
		
		protected function onTouchCloseButton(e:TouchEvent):void
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
					WindowsManager.hide();
				}
				
				if (touch.phase == TouchPhase.HOVER)
				{
					
				}
			}
		}
		
		override protected function onResize(e:Event = null):void
		{
			this.x = stage.stageWidth >> 1;
			this.y = stage.stageHeight >> 1;
		}
		
		private function createCloseButton():void
		{
			_clsoeButton = new Button(MAssetManager._assetManager.getTexture(TextureNameConst.BTN_CLOSE));
			addChild(_clsoeButton);
			_clsoeButton.x = _background.width - _clsoeButton.width;
			_clsoeButton.y = _clsoeButton.width >> 1;
		}
		
		private function createBackground():void
		{
			_background = new MImage(TextureNameConst.WINDOW_SMALL);
			addChild(_background);
		}
	}
}