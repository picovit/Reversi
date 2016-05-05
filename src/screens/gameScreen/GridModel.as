package screens.gameScreen
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import configs.ConfigModel;
	
	import grids.GridEvents;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class GridModel extends EventDispatcher
	{
		public var grid:Array;
		private var _turn:Boolean;
		static public const WHITE:Boolean = true;
		static public const BLACK:Boolean = false;
		private var _blackScore:uint;
		private var _whiteScore:uint;
		static public var playerMode:String;
		static public var singlePlayerMode:String = "singlePlayerMode";
		static public var twoPlayerModel:String = "twoPlayerMode";
		static public var computerColor:Boolean = true;
		private var BLACK_COLOR_NAME:String = "BLACK";
		private var WHITE_COLOR_NAME:String = "WHITE";
		
		private var copy_grid:Array;
		
		static private var _init:GridModel
		
		static public function get instance():GridModel
		{
			if(!_init) _init = new GridModel();
			return _init;
		}
		
		public function GridModel()
		{
			turn = BLACK;
		}
		
		public function get whiteScore():uint
		{
			return _whiteScore;
		}

		public function set whiteScore(value:uint):void
		{
			_whiteScore = value;
			dispatchEvent(new Event(GridEvents.CHANGE_WHITE_SCORE, false, value));
		}

		public function get blackScore():uint
		{
			return _blackScore;
		}

		public function set blackScore(value:uint):void
		{
			_blackScore = value;
			dispatchEvent(new Event(GridEvents.CHANGE_BLACK_SCORE, false, value));
		}

		public function get turn():Boolean
		{
			return _turn;
		}

		public function set turn(value:Boolean):void
		{
			_turn = value;
			dispatchEvent(new Event(GridEvents.CHANGE_TURN, false, value));
		}

		public function createGrid():void
		{
			grid = new Array(ConfigModel.boardSize);
			for (var i:uint = 0; i < ConfigModel.boardSize; i++)
			{
				grid[i] = new Array(ConfigModel.boardSize);
			}
			dispatchEvent(new Event(GridEvents.CREATE_GRID));
		}
		
		public function setStartGrid():void
		{
			grid[3][3] = WHITE;
			grid[4][4] = WHITE;
			grid[4][3] = BLACK;
			grid[3][4] = BLACK;
			
			dispatchEvent(new Event(GridEvents.SET_START_GRID));
//			console();
			calculateScore();
			makeArtificialMove();
		}
		
		private function makeArtificialMove():void
		{
			var moves:Array = findPossibleMoves(grid);
			
			if (playerMode == singlePlayerMode && turn == computerColor)
			{
				dispatchEvent(new Event(GridEvents.BLOCK_BOARD, false, false));
				var computerWait:Timer = new Timer(1000, ConfigModel.comuterWaitTime);
				computerWait.start();
				computerWait.addEventListener(TimerEvent.TIMER_COMPLETE, complete);
				
				function complete():void
				{
					computerWait.removeEventListener(TimerEvent.TIMER_COMPLETE, complete);
					var bestTurn:* = findComputerTurn(moves);
					makeMove(bestTurn.x, bestTurn.y);
//					copyGrid();
					dispatchEvent(new Event(GridEvents.BLOCK_BOARD, false, true));
					return;
				}	
			}
			else
			{
				dispatchEvent(new Event(GridEvents.ADD_SHOW_POSSIBLE_MOVE, false, moves));
			}
		}
		
		private function findPossibleMoves(grid:Array):Array
		{
			var capture:uint;
			var captures:Array = new Array();
			
			for (var i:int = 0; i < grid.length; i++) 
			{
				for (var j:int = 0; j < grid[i].length; j++) 
				{
					if (findCaptures(turn, i, j, false) != 0)
					{
						capture = findCaptures(turn, i, j, false, grid);
						captures.push({x:i, y:j, turn:capture});
					}
				}
			}
			return captures;
		}
		
		private function copyGrid():void
		{
			copy_grid = new Array(ConfigModel.boardSize);
			for (var i:uint = 0; i < ConfigModel.boardSize; i++)
			{
				copy_grid[i] = new Array(ConfigModel.boardSize);
			}
			
			for (var j:int = 0; j < grid.length; j++) 
			{
				for (var k:int = 0; k < grid[j].length; k++) 
				{
					if (grid[j][k] != null) 
					{
						copy_grid[j][k] = grid[j][k];
					}
				}
			}		
//			trace("")
		}
		
		private function findComputerTurn(data:Array):Object
		{
			var maxTurns:uint;
			var bestTurn:Object;
			for (var i:int = 0; i < data.length; i++) 
			{
				maxTurns = data[0].turn;
				bestTurn = data[0];
				if (data[i].turn > maxTurns)
				{
					maxTurns = data[i].turn;
					bestTurn = data[i];
				}
			}
			return bestTurn;
		}
		
		public function makeMove(x:uint, y:uint):void
		{
			if (grid[x][y] != null) return;
			if (findCaptures(turn, x, y, true) == 0) return;
			grid[x][y] = turn;
				
			var data:* = {x:x, y:y, turn:turn};
				
			onTurnFinished(true);
			dispatchEvent(new Event(GridEvents.PLACE_CHIP, false, data));
			if (isNextMovePossible(this.turn)) makeArtificialMove();
		}
		
		private function findCaptures(turn:Boolean, x:uint, y:uint, turnStones:Boolean, grid:Array = null):uint
		{
			grid = (grid == null) ? this.grid : grid;
			if (grid[x][y] != null) return 0;
			var topLeft:uint     = walkPath(turn, x, y, -1, -1, turnStones, grid);
			var top:uint         = walkPath(turn, x, y,  0, -1, turnStones, grid);
			var topRight:uint    = walkPath(turn, x, y,  1, -1, turnStones, grid);
			var right:uint       = walkPath(turn, x, y,  1,  0, turnStones, grid);
			var bottomRight:uint = walkPath(turn, x, y,  1,  1, turnStones, grid);
			var bottom:uint      = walkPath(turn, x, y,  0,  1, turnStones, grid);
			var bottomLeft:uint  = walkPath(turn, x, y, -1,  1, turnStones, grid);
			var left:uint        = walkPath(turn, x, y, -1,  0, turnStones, grid);
			return (topLeft + top + topRight + right + bottomRight + bottom + bottomLeft + left);
		}
		
		private function walkPath(turn:Boolean, x:uint, y:uint, xFactor:int, yFactor:int, turnChip:Boolean, stones:Array):uint
		{
			if (x + xFactor > grid.length - 1 || x + xFactor < 0 || y + yFactor > grid[0].length - 1 || y + yFactor < 0) return 0;
			
			if (stones[x + xFactor][y + yFactor] == null) return 0;
			
			var nextStone:Boolean = stones[x + xFactor][y + yFactor];
			
			if (nextStone != !turn)
			{
				return 0;
			}
			
			var tmpX:int = x, tmpY:int = y;
			var chipCount:uint = 0;
			while (true)
			{
				chipCount++;
				tmpX = tmpX + xFactor;
				tmpY = tmpY + yFactor;
				if (tmpX < 0 || tmpY < 0 || tmpX > grid.length - 1 || tmpY > grid[0].length - 1 || stones[tmpX][tmpY] == null)
				{
					return 0;
				}
				nextStone = grid[tmpX][tmpY];
				if (nextStone == turn)
				{
					if (turnChip) turnChips(turn, x, y, tmpX, tmpY, xFactor, yFactor, stones);
					return chipCount - 1;
				}
			}
			return 0;
		}
		
		private function turnChips(turn:Boolean, fromX:uint, fromY:uint, toX:uint, toY:uint, xFactor:uint, yFactor:uint, grid:Array):void
		{
			var nextX:uint = fromX, nextY:uint = fromY;
			var chipsToTurn:Array = new Array();
			while (true)
			{
				nextX = nextX + xFactor;
				nextY = nextY + yFactor;
				grid[nextX][nextY] = turn;
				if (grid == this.grid)
				{
					if (toX != nextX || toY != nextY)
					{
						chipsToTurn.push({turn:turn, x:nextX, y:nextY});
					}
				}
				if (nextX == toX && nextY == toY)
				{
					dispatchEventWith(GridEvents.ANIMATE_CHIPS, false, chipsToTurn);
					break;
				}
			}
		}
		
		private function onTurnFinished(changeTurn:Boolean):void
		{
			if (changeTurn) this.changeTurn();
			calculateScore();
			if (isNextMovePossible(turn)) return;
			
			if ((blackScore + whiteScore) == ConfigModel.boardSize*ConfigModel.boardSize)
			{
				var winner:String = (blackScore > whiteScore) ? BLACK_COLOR_NAME : WHITE_COLOR_NAME;
				dispatchEvent(new Event(GridEvents.ALL_CHIPS_PLAYED, false, winner));
				return;
			}
			
			if (blackScore == 0 || whiteScore == 0)
			{
				var winner:String = (this.blackScore == 0) ? BLACK_COLOR_NAME : WHITE_COLOR_NAME;
				var loser:String = (this.blackScore != 0) ? BLACK_COLOR_NAME : WHITE_COLOR_NAME;
				dispatchEvent(new Event(GridEvents.ALL_CHIPS_CAPTURED, false, {winner:winner, loser:loser}));
				return;
			}
			
			if (!isNextMovePossible(!turn))
			{
				if (blackScore == whiteScore)
				{
					dispatchEvent(new Event(GridEvents.TIE_GAME));
					return;
				}
				var winner:String = (blackScore > whiteScore) ? BLACK_COLOR_NAME : WHITE_COLOR_NAME;
				dispatchEvent(new Event(GridEvents.NEITHER_CAN_MAKE_MOVE, false, winner));
				return;
			}
			
			if (changeTurn) this.changeTurn();
			var from:String = (turn == WHITE) ? BLACK_COLOR_NAME : WHITE_COLOR_NAME;
			var to:String = (turn != WHITE) ? BLACK_COLOR_NAME : WHITE_COLOR_NAME;
			
			dispatchEvent(new Event(GridEvents.NO_MOVE_AVAILABLE, false, {from:from, to:to}));
		}
		
		private function isNextMovePossible(turn:Boolean):Boolean
		{
			for (var i:uint = 0; i < grid.length; i++)
			{
				for (var j:uint = 0; j < grid[i].length; j++)
				{
					if (grid[i][j] != null) continue;
					if (findCaptures(turn, i, j, false) > 0) return true;
				}
			}
			return false;
		}
		
		private function changeTurn():void
		{
			turn = !turn;
		}
		
		private function calculateScore():void
		{
			var black:uint = 0;
			var white:uint = 0;
			for (var i:uint = 0; i < grid.length; i++)
			{
				for (var j:uint = 0; j < grid[i].length; j++)
				{
					if (grid[i][j] == null)
					{
						continue;
					}
					else if (this.grid[i][j] == WHITE)
					{
						white ++;
					}
					else
					{
						black ++;
					}
				}
			}
			blackScore = black;
			whiteScore = white;
//			trace("blackScore:", blackScore, "whiteScore:", whiteScore);
		}
		
		public function destroyModel():void
		{
			grid = null;
		}
		
		protected function console():void
		{
			var str:String = '';
			
			for (var i:int = 0; i < ConfigModel.boardSize; i++) 
			{
				for (var j:int = 0; j < ConfigModel.boardSize; j++) 
				{
					str = str + grid[j][i] + " "
//					if( grid[i][j]) str = str + grid[i][j] + " ";
//					else str = str + '.' + " ";
				}
				str = str + "\n";
			}
			trace(str);
			trace('----------------------');
		}
	}
}