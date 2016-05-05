package engine
{
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class MAssetManager
	{
		static public var _assetManager:AssetManager;
		
		public function MAssetManager()
		{
			createAssetManager();
		}
		
		private function createAssetManager():void
		{
			_assetManager = new AssetManager();
//			_assetManager.enqueue("../assets/textures/ui.xml");
//			_assetManager.enqueue("../assets/textures/ui.png");
			
//			_assetManager.loadQueue(function(ratio:Number):void{
//				if (ratio == 1)
//				{
//					dispatchEvent(new Event(EngineEvents.ASSETS_LOAD_COMPLETE));
//				}
//			});
			trace("_assetManager");
		}
		
		public function getTexture(name:String):Texture
		{
			return _assetManager.getTexture(name);
		}
		
		public function getTextures(prefix:String="", result:Vector.<Texture>=null):Vector.<Texture>
		{
			return _assetManager.getTextures(prefix, result);
		}
		
		public function getExternalData(name:String):Object
		{
			return null;
		}
	}
}