package
{
	import configs.ConfigLoader;
	
	import engine.EngineEvents;
	import engine.MAssetLoader;
	import engine.MAssetManager;
	
	import screens.ScreenManager;
	import screens.mapScreen.MapScreen;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import windows.WindowsManager;
	
	public class MainApplication extends Sprite
	{
		private var configLoader:ConfigLoader;
		private var mAssetManager:MAssetManager;
		static public var assetPath:String;
		private var mAssetLoader:MAssetLoader;
		
		public function MainApplication()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			configLoader = new ConfigLoader();
			configLoader.addEventListener(EngineEvents.CONFIG_LOAD_COMPLETE, config);
		}
		
		private function config(e:Event):void
		{	
			mAssetManager = new MAssetManager();
			mAssetLoader = new MAssetLoader();
			mAssetLoader.load();
			mAssetLoader.addEventListener(EngineEvents.ASSETS_LOAD_COMPLETE, start);
			
			registrationManagers();
		}
		
		private function registrationManagers():void
		{
			WindowsManager.mainSprite = this;
			ScreenManager.mainSprite = this;
			WindowsManager.addListeners();
		}
		
		private function start():void
		{		
			ScreenManager.show(MapScreen);
		}
		
		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
	}
}