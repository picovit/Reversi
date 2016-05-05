package windows
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import screens.ScreenManager;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class WindowsManager extends Sprite
	{
		static private var _winStack:Vector.<Sprite>;
		static private var _backGround:Sprite;
		static private var _currentWin:*;
		static public var windowStack:Array = new Array();
		static public var AMOUNT:int = 0; 
		static private var _isView:Boolean = false;
		
		static private var _touchable:Boolean;
		static private var _backAlpha:Number = 0.5;
		static private var _quad:Quad;
		static public var mainSprite:Sprite;
		
		public static function get isView():Boolean
		{
			return _isView;
		}

		public static function set isView(value:Boolean):void
		{
			_isView = value;
		}

		static private var __onAllWindowCloseFunction:Function;
		static private var __onAllWindowCloseParams:Array;
		static private var __onAllWindowCloseTarget:Object;
		
		
		public function WindowsManager()
		{
			
		}
		
		static public function addListeners():void
		{
			mainSprite.stage.addEventListener( Event.RESIZE, onResize);
		}
		
		static public function removeListeners():void
		{
			mainSprite.stage.removeEventListener( Event.RESIZE, onResize);		
		}
		
		static private function onResize():void
		{
			if(_backGround)
			{
				_quad.width = mainSprite.stage.stageWidth;
				_quad.height = mainSprite.stage.stageHeight;
			}
		}
		
		public static function get backAlpha():Number
		{
			return _backAlpha;
		}

		public static function set backAlpha(value:Number):void
		{
			_backAlpha = value;
			if(_backGround && _backGround.getChildByName("back")) _backGround.getChildByName("back").alpha = _backAlpha
		}

		private static function touchable(o:Object):void
		{
			_backGround.touchable = o["touchable"];
			_currentWin.touchable = o["touchable"];
		}

		static public function show(winClass:Class,... params):void
		{
			if(!isView) showCurrentWindow(winClass, params);
			else windowStack.push( {"window" : winClass, "params" : params} );

		}
		
		private static function showCurrentWindow(winClass:Class, params:*):void
		{	
			isView = true;
			
			if(params.length) _currentWin =  new winClass(params);
			else _currentWin = new winClass();
			
			createBackGround();
			_backGround.addChild( _currentWin );
			animate(_currentWin);
			
			if(params.length && (params[params.length - 1] != null ) && params[params.length - 1].hasOwnProperty("touchable"))
			{
				touchable(params[params.length - 1]);
			}
		}
		
		static private function animate(spr:Sprite):void
		{			
			spr.x = mainSprite.stage.stageWidth >> 1 ;
			spr.y = mainSprite.stage.stageHeight >> 1;

			try
			{
				(spr['show'] as Function).call(); 
			} 
			catch(error:Error) 
			{
				TweenLite.from(spr, 1, { alpha:0, scaleX:0.3, scaleY:0.3, ease:Back.easeOut } );
			}
			
			ScreenManager.blurScreen();
		}
		
		static public function hide(fun:Function = null):void
		{
			if(_currentWin == null){ workingCall(); return; }
			TweenMax.to(_currentWin, .45, { alpha:0, scaleX:0.3, scaleY:0.3, ease:Back.easeOut, onComplete:completeHidingWindow});
			ScreenManager.normalScreen();
			
			function completeHidingWindow():void
			{
				AMOUNT++;
				if(!isView){
					workingCall();
					return;
				}

				_backGround.removeChild( _currentWin );
				mainSprite.removeChild(_backGround);
				
				isView = false;
				_currentWin = null;
				_backGround = null;
				
				if(windowStack.length)
				{
					showCurrentWindow(windowStack[0]["window"], windowStack[0]["params"]);
					windowStack.shift();
				}
				else
				{
					if(__onAllWindowCloseFunction != null)
					{
						__onAllWindowCloseFunction.apply(__onAllWindowCloseTarget, __onAllWindowCloseParams); 
						__onAllWindowCloseFunction = null;
					}
				}
				workingCall();
			}
			
			function workingCall():void
			{
            	if(fun) fun.call();
			}
		}
		
		static public function onAllwindowClose(target:Object, fun:Function, params:Object):void
		{
			__onAllWindowCloseFunction = fun;
			__onAllWindowCloseParams = [params];
			__onAllWindowCloseTarget = target;
		}
		
		static private function createBackGround():void
		{
			_backGround = new Sprite();
			
				_quad = new Quad(mainSprite.stage.stageWidth, mainSprite.stage.stageHeight); 
				_quad.color = 0x000000;
				_quad.alpha = _backAlpha;
				_quad.name = "back"
				_backGround.addChild( _quad );
				mainSprite.addChild(_backGround);
		}		
	}
}