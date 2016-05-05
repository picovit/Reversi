package screens
{
	import starling.display.Sprite;
	import starling.filters.BlurFilter;

	public class ScreenManager
	{
		static public var mainSprite:Sprite;
		static private var __screenSprite:Sprite;
		static private var __screenName:Class;
		
		public static function get screen():Sprite
		{
			return __screenSprite;
		}

		static public function show(screenName:Class,  ... params):void
		{
			__screenName = screenName;
			if(__screenSprite != null)
			{
				/*disposeAllObjects(__screenSprite);
				disposeAllObjects(mainSprite);*/
				mainSprite.removeChild( __screenSprite );
				__screenSprite = null;
			}
			
			if(params.length)  __screenSprite = new screenName(params);
			else __screenSprite = new screenName();
			
			mainSprite.addChild( __screenSprite );
		}
		
		static public function get SCREEN_NAME():Class
		{
			return __screenName;
		}
		
		static public function blurScreen():void
		{
			//var bf:BlurFilter = new BlurFilter(2, 2, 0.6);
//			__screenSprite.filter = bf;
//			bf.blurX
		}
		
		static public function normalScreen():void
		{
			__screenSprite.filter = null;
		}
	}
}