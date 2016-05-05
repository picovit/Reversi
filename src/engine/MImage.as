package engine
{
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
//	import starling.textures.TextureSmoothing;
	
	public class MImage extends Image
	{
		private var _texture:Texture;
		private var _textureX:Number;
		private var _textureY:Number;
		
		public function MImage(textureName:String, textureX:Number = 0, textureY:Number = 0, touchable:Boolean = false)
		{
			_texture = MAssetManager._assetManager.getTexture(textureName);
			_textureX = textureX;
			_textureY = textureY;
			super(_texture);
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
//			this.smoothing = TextureSmoothing.TRILINEAR;
			this.touchable = touchable;
//			this.x = _textureX*Engine.GlobalSize;
//			this.y = _textureY*Engine.GlobalSize;
		}
		
		private function destroy(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			this.texture.dispose();
		}
	}
}