package engine
{
	import flash.net.URLLoaderDataFormat;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class MAssetLoader extends EventDispatcher
	{
		private var _assetsPath:String = Service.instance.configModel.assetsPath;
		private var _assets:Array;
		private var xml:XML;
		private var atf:Texture;
		private var fileName:String;
		
		public function MAssetLoader()
		{
			var context:LoaderContext = new LoaderContext(); 
			context.checkPolicyFile = true;
			
			_assets = new Array();
			for (var i:int = 0; i < Service.instance.configModel.assets.length; i++) 
			{
				_assets.push(Service.instance.configModel.assets[i]);
			}
		}
		
		public function load():void
		{
			if (_assets.length == 0) 
			{
				dispatchEvent(new Event(EngineEvents.ASSETS_LOAD_COMPLETE));
				return;
			}
			fileName = _assets[0];
			_assets.shift();
			
			var cache:int = Math.random()*int.MAX_VALUE;
			var url:String = _assetsPath + fileName + ".atf?" + cache;
			new MUrlLoader(url, onLoadATF, URLLoaderDataFormat.BINARY);
		}
		
		private function onLoadATF(data:Object):void
		{
			atf = Texture.fromAtfData(data as ByteArray);
			var cache:int = Math.random()*int.MAX_VALUE;
			var url:String = _assetsPath + fileName + ".xml?" + cache;
			new MUrlLoader(url, onLoadXML, URLLoaderDataFormat.TEXT);
		}
		
		private function onLoadXML(data:String):void
		{
			xml = XML(data);
			var atlas:TextureAtlas = new TextureAtlas(atf, xml);	
			MAssetManager._assetManager.addTextureAtlas(fileName, atlas);
			load.call();
		}
	}
}