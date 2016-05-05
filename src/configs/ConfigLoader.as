package configs
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	import engine.EngineEvents;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class ConfigLoader extends EventDispatcher
	{
		public function ConfigLoader()
		{
			var context:LoaderContext = new LoaderContext(); 
				context.checkPolicyFile = true;
			
			var url:String = "../assets/configs/config.json"; 
			
			var urlReq:URLRequest = new URLRequest(url);
			
			var urlLoader:URLLoader = new URLLoader(urlReq);
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				urlLoader.load(urlReq);
				urlLoader.addEventListener(flash.events.Event.COMPLETE, onCompleteLoad);
		}
		
		protected function onCompleteLoad(e:flash.events.Event):void
		{
			var configData:String = e.currentTarget.data;
			trace(configData);
			var pareseData:Object = JSON.parse(configData);
			ConfigController.instance.init(pareseData);
			dispatchEvent(new starling.events.Event(EngineEvents.CONFIG_LOAD_COMPLETE));
		}
	}
}