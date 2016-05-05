package
{
	import flash.display.Sprite;
	
	import starling.events.Event;
	
	[SWF(frameRate=60, width=760, height=675)]
	
	public class Reversi extends Sprite
	{
		private var _starlingManager:StarlingManager;
		
		public function Reversi()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_starlingManager = new StarlingManager(stage);
		}
		
		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
	}
}