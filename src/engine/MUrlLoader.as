package engine
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class MUrlLoader
	{
		public function MUrlLoader(url:String, call:Function, dataFormat:String)
		{
			var req:URLRequest = new URLRequest(url);
			var loader:URLLoader = new URLLoader();
			
			loader.dataFormat = dataFormat;
			
			loader.load(req);
			
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			
			function onLoadComplete(e:Event):void
			{
				if(call) call( (e.currentTarget as URLLoader).data );					
				loader.removeEventListener(Event.COMPLETE, onLoadComplete);
			}
		}
	}
}