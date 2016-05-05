package screens.gameScreen
{
	import configs.ConfigModel;
	
	import engine.MSprite;
	
	import grids.GridCell;
	import grids.GridEvents;
	
	import starling.display.DisplayObject;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import windows.InfoGameWindow;
	import windows.WindowsManager;

	public class GridView extends MSprite
	{
		private var _model:GridModel;
		private var _controller:IController;
		private var _gridCells:Vector.<Vector.<GridCell>>;
		private var _possibleMoves:Array;
		
		public function GridView(model:GridModel, controller:IController, stage:Stage)
		{
			_model = model;
			_controller = controller;
			
			_model.addEventListener(GridEvents.SET_START_GRID, updateGrid);
			_model.addEventListener(GridEvents.ANIMATE_CHIPS, animateChips);
			_model.addEventListener(GridEvents.PLACE_CHIP, createChip);
			_model.addEventListener(GridEvents.ADD_SHOW_POSSIBLE_MOVE, addShowPossibleMove);
			_model.addEventListener(GridEvents.ALL_CHIPS_PLAYED, allChipsPlayed);
			_model.addEventListener(GridEvents.ALL_CHIPS_CAPTURED, allChipsCaptured);
			_model.addEventListener(GridEvents.TIE_GAME, tieGame);
			_model.addEventListener(GridEvents.NEITHER_CAN_MAKE_MOVE, neitherCanMakeMove);
			_model.addEventListener(GridEvents.NO_MOVE_AVAILABLE, noMoveAvailable);
			_model.addEventListener(GridEvents.BLOCK_BOARD, blockBoard);
		}
		
		private function blockBoard(e:Event):void
		{
			this.touchable = Boolean(e.data);
		}
		
		private function noMoveAvailable(e:Event):void
		{
			var from:String = String(e.data["from"]);
			var to:String = String(e.data["to"]);
			var message:String = String(ConfigModel.noMoveAvailableText1 + from + ConfigModel.noMoveAvailableText2 + to + ConfigModel.noMoveAvailableText3);
			InfoGameWindow.titleTfText = ConfigModel.noMoveAvailableTitle;
			InfoGameWindow.message = message;
			WindowsManager.show(InfoGameWindow);
		}
		
		private function neitherCanMakeMove(e:Event):void
		{
			var winner:String = String(e.data);
			var message:String = String(winner + ConfigModel.neitherCanMakeMoveText1 + ConfigModel.neitherCanMakeMoveText2 + winner + ConfigModel.neitherCanMakeMoveText3);
			InfoGameWindow.titleTfText = ConfigModel.neitherCanMakeMoveTitle;
			InfoGameWindow.message = message;
			WindowsManager.show(InfoGameWindow);
		}
		
		private function tieGame(e:Event):void
		{
			var message:String = String(ConfigModel.tieGameText1);
			InfoGameWindow.titleTfText = ConfigModel.tieGameTitle;
			InfoGameWindow.message = message;
			WindowsManager.show(InfoGameWindow);
		}
		
		private function allChipsPlayed(e:Event):void
		{
			var winner:String = String(e.data);
			var message:String = String(winner + ConfigModel.allChipsPlayedText1 + ConfigModel.allChipsPlayedText2);
			InfoGameWindow.titleTfText = ConfigModel.allChipsPlayedTitle;
			InfoGameWindow.message = message;
			WindowsManager.show(InfoGameWindow);
		}
		
		private function allChipsCaptured(e:Event):void
		{
			var winner:String = e.data.winner;
			var loser:String = e.data.loser;
			var message:String = String(winner + ConfigModel.allChipsCapturedText1 +  winner + ConfigModel.allChipsCapturedText2 + loser + ConfigModel.allChipsCapturedText3);
			InfoGameWindow.titleTfText = ConfigModel.allChipsCapturedTitle;
			InfoGameWindow.message = message;
			WindowsManager.show(InfoGameWindow);
		}
		
		private function addShowPossibleMove(e:Event):void
		{
			_possibleMoves = (e.data) as Array;
			
			for (var i:int = 0; i < _possibleMoves.length; i++) 
			{
				_gridCells[_possibleMoves[i].x][_possibleMoves[i].y].addAnimateCell();
			}
		}
		
		private function removeShowPossibleMove():void
		{
			if (_possibleMoves == null) return;
			for (var i:int = 0; i < _possibleMoves.length; i++) 
			{
				_gridCells[_possibleMoves[i].x][_possibleMoves[i].y].removeAnimateCell();
			}
		}
		
		private function createChip(e:Event):void
		{
			var chip:* = (e.data) as Object;
			_gridCells[chip.x][chip.y].createChip(chip.turn);
			removeShowPossibleMove();
		}
		
		private function animateChips(e:Event):void
		{
			var chips:Array = (e.data) as Array;
			for (var i:int = 0; i < chips.length; i++) 
			{
				_gridCells[chips[i].x][chips[i].y].animateChip(chips[i].turn);
			}
		}
		
		private function onTouchGrid(e:TouchEvent):void
		{
			var touches:Vector.<Touch> = e.getTouches(e.currentTarget as DisplayObject);
			
			var gridCell:GridCell = (e.currentTarget as GridCell);
			
			if (touches.length == 0)
			{
			}
			
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					
				}
				
				if (touch.phase == TouchPhase.ENDED)
				{
					_controller.makeMove(gridCell.position.x, gridCell.position.y);
				}
				
				if (touch.phase == TouchPhase.HOVER)
				{
					
				}
			}
		}
		
		private function updateGrid():void
		{
			_gridCells = new Vector.<Vector.<GridCell>>();
			var temp:Vector.<GridCell>;
			var gridCell:GridCell;
			
			for (var i:int = 0; i < _model.grid.length; i++) 
			{
				temp = new Vector.<GridCell>();
				for (var j:int = 0; j < _model.grid[i].length; j++)
				{
					gridCell = new GridCell(i, j)
					addChild(gridCell);
					gridCell.x = (gridCell.width + ConfigModel.cellSpace)*i;
					gridCell.y = (gridCell.height + ConfigModel.cellSpace)*j;
					temp.push(gridCell);
					gridCell.addEventListener(TouchEvent.TOUCH, onTouchGrid);
				}
				_gridCells.push(temp);
			}
			
			placeChips();
		}	
		
		private function placeChips():void
		{
			for (var i:int = 0; i < _model.grid.length; i++) 
			{
				for (var j:int = 0; j < _model.grid[i].length; j++) 
				{
					if (_model.grid[i][j] == null) continue;
					placeChip(_model.grid[i][j], i, j);
				}
			}
		}
		
		private function placeChip(color:Boolean, i:uint, j:uint):void
		{
			_gridCells[i][j].createChip(color);
		}
		
		override protected function init(e:Event = null):void
		{
			super.init(e);
			
			_controller.startGame();
		}
	}
}