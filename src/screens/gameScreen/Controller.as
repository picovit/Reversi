package screens.gameScreen
{
	public class Controller implements IController
	{
		private var _model:GridModel;
		public function Controller(model:GridModel)
		{
			_model = model;
		}
		
		public function startGame():void
		{
			_model.createGrid();
			_model.setStartGrid();
		}
		
		public function makeMove(x:uint, y:uint):void
		{
			_model.makeMove(x, y);
		}
	}
}