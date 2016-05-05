package windows
{
	import configs.ConfigModel;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFormat;

	public class InfoGameWindow extends SimpleWindow
	{
		private var _titleTf:TextField;
		private var _descriptionTf:TextField;
		public static var message:String;
		public static var titleTfText:String;
		
		public function InfoGameWindow()
		{
			super();
		}
		override protected function init(e:Event = null):void
		{
			super.init(e);
			createTitle();
			createDiscription();
		}
		
		private function createTitle():void
		{
			var tfFormat:TextFormat = new TextFormat(ConfigModel.infoGameWindowTitleTfFont, ConfigModel.infoGameWindowTitleTfSize);
			
			_titleTf = new TextField(ConfigModel.infoGameWindowTitleTfWidth, ConfigModel.infoGameWindowTitleTfHeight, titleTfText, tfFormat);
			addChild(_titleTf);
			_titleTf.x = (this.width - _titleTf.width) >> 1;
			_titleTf.y = _titleTf.height >> 1;
		}
		
		private function createDiscription():void
		{
			var tfFormat:TextFormat = new TextFormat(ConfigModel.infoGameWindowDescTfFont, ConfigModel.infoGameWindowDescTfSize);
			
			_descriptionTf = new TextField(ConfigModel.infoGameWindowDescTfWidth, ConfigModel.infoGameWindowDescTfHeight, message, tfFormat);
			addChild(_descriptionTf);
			_descriptionTf.x = (this.width - _descriptionTf.width) >> 1;
			_descriptionTf.y = (this.height - _descriptionTf.height) >> 1;
		}
		
		
		override protected function destroy(e:Event):void
		{
			super.destroy(e);
		}
	}
}