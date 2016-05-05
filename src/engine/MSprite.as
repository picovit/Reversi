package engine
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MSprite extends Sprite
	{
		public function MSprite()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function addListeners():void
		{
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function removeListeners():void
		{
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		
		protected function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addListeners();
		}
		
		protected function onResize(e:Event = null):void
		{
			
		}
		
		protected function destroy(e:Event):void
		{
			removeListeners();
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
	}
}