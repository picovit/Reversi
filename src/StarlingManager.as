package
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;

	public class StarlingManager
	{
		private var _starling:Starling;
		private var _stage:Stage;
		
		public function StarlingManager(stage:Stage)
		{
			_stage = stage;
			
			initialization();
		}
		
		private function initialization():void
		{
			var stageSize:Rectangle  = new Rectangle(0, 0, _stage.stageWidth, _stage.stageHeight);
			var screenSize:Rectangle = new Rectangle(0, 0, _stage.fullScreenWidth, _stage.fullScreenHeight);
			var viewPort:Rectangle = stageSize;
			
			_starling = new Starling(MainApplication, _stage, new Rectangle(0, 0, _stage.stageWidth, _stage.stageHeight));
//			_starling.showStats = true ;
			_starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, startStarling);
		}
		
		private function startStarling(e:Event):void
		{
			_starling.start();
			_stage.addEventListener(flash.events.Event.RESIZE, onResize);
		}
		
		private function onResize(e:Event):void
		{
			var viewRect:Rectangle = new Rectangle(0, 0, _stage.stageWidth, _stage.stageHeight);
			_starling.viewPort = viewRect;
			_starling.stage.stageWidth = _stage.stageWidth;
			_starling.stage.stageHeight = _stage.stageHeight;
		}
	}
}