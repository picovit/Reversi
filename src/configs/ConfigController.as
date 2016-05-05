package configs
{
	public class ConfigController
	{
		static private var _init:ConfigController
		
		static public function get instance():ConfigController
		{
			if(!_init) _init = new ConfigController();
			return _init;
		}
		
		public function init(o:*):void
		{
			var configModel:ConfigModel = new ConfigModel();
				configModel.assetsPath = o.config.assetsPath;
				
				//board
				ConfigModel.boardSize = o.config.board.size;
				ConfigModel.cellSpace = o.config.board.cellSpace;
				//cell
				ConfigModel.cellSize = o.config.cell.size;
				ConfigModel.cellAlpha = o.config.cell.alpha;
				ConfigModel.cellColor = o.config.cell.color;
				ConfigModel.cellPossibleColor = o.config.cell.possibleColor;
				ConfigModel.cellPossibleAlphaAnimation = o.config.cell.cellPossibleAnimate.alpha;
				ConfigModel.cellPossibleTimeAnimation = o.config.cell.cellPossibleAnimate.time;
				ConfigModel.cellPossibleEaseAnimation = o.config.cell.cellPossibleAnimate.ease;
				//chip
				ConfigModel.chipSize = o.config.chip.size;
				ConfigModel.chipAlpha = o.config.chip.alpha;
				ConfigModel.chipWhiteColor = o.config.chip.whiteColor;
				ConfigModel.chipBlackColor = o.config.chip.blackColor;
				ConfigModel.chipTurnTimeAnimation = o.config.chip.chipTurnAnimation.time;
				ConfigModel.chipTurnEaseAnimation = o.config.chip.chipTurnAnimation.ease;
				
				ConfigModel.chipCreateTimeAnimation = o.config.chip.chipCreateAnimation.time;
				ConfigModel.chipCreateFromVarsAnimation = o.config.chip.chipCreateAnimation.fromVars.scale;
				ConfigModel.chipCreateToVarsAnimation = o.config.chip.chipCreateAnimation.toVars.scale;
				
				//btn
				ConfigModel.startGameBtnFont = o.config.startGameBtn.font;
				ConfigModel.startGameBtnSize = o.config.startGameBtn.size;
				ConfigModel.startGameBtnText = o.config.startGameBtn.text;
				
				ConfigModel.singlePlayerBtnFont = o.config.singlePlayerBtn.font;
				ConfigModel.singlePlayerBtnSize = o.config.singlePlayerBtn.size;
				ConfigModel.singlePlayerBtnText = o.config.singlePlayerBtn.text;
				
				ConfigModel.twoPlayerBtnFont = o.config.twoPlayerBtn.font;
				ConfigModel.twoPlayerBtnSize = o.config.twoPlayerBtn.size;
				ConfigModel.twoPlayerBtnText = o.config.twoPlayerBtn.text;
				
				ConfigModel.playBlackBtnFont = o.config.playBlackBtn.font;
				ConfigModel.playBlackBtnSize = o.config.playBlackBtn.size;
				ConfigModel.playBlackBtnText = o.config.playBlackBtn.text;
				
				ConfigModel.playWhiteBtnFont = o.config.playWhiteBtn.font;
				ConfigModel.playWhiteBtnSize = o.config.playWhiteBtn.size;
				ConfigModel.playWhiteBtnText = o.config.playWhiteBtn.text;
				//title
				ConfigModel.startGameWindowTitleTfFont = o.config.startGameWindowTitleTf.font;
				ConfigModel.startGameWindowTitleTfHeight = o.config.startGameWindowTitleTf.height;
				ConfigModel.startGameWindowTitleTfWidth = o.config.startGameWindowTitleTf.width;
				ConfigModel.startGameWindowTitleTfSize = o.config.startGameWindowTitleTf.size;
				ConfigModel.startGameWindowTitleTfText = o.config.startGameWindowTitleTf.text;
				
				ConfigModel.choiseChipWindowTitleTfFont = o.config.choiseChipWindowTitleTf.font;
				ConfigModel.choiseChipWindowTitleTfHeight = o.config.choiseChipWindowTitleTf.height;
				ConfigModel.choiseChipWindowTitleTfWidth = o.config.choiseChipWindowTitleTf.width;
				ConfigModel.choiseChipWindowTitleTfSize = o.config.choiseChipWindowTitleTf.size;
				ConfigModel.choiseChipWindowTitleTfText = o.config.choiseChipWindowTitleTf.text;
				
				//score tf
				ConfigModel.scoreTfFont = o.config.scoreTf.font;
				ConfigModel.scoreTfSize = o.config.scoreTf.size;
				ConfigModel.scoreTfWidth = o.config.scoreTf.width;
				ConfigModel.scoreTfHeight = o.config.scoreTf.height;
				
				ConfigModel.infoGameWindowTitleTfFont = o.config.infoGameWindowTitleTf.font;
				ConfigModel.infoGameWindowTitleTfSize = o.config.infoGameWindowTitleTf.size;
				ConfigModel.infoGameWindowTitleTfWidth = o.config.infoGameWindowTitleTf.width;
				ConfigModel.infoGameWindowTitleTfHeight = o.config.infoGameWindowTitleTf.height;
				
				ConfigModel.infoGameWindowDescTfFont = o.config.infoGameWindowDescTf.font;
				ConfigModel.infoGameWindowDescTfSize = o.config.infoGameWindowDescTf.size;
				ConfigModel.infoGameWindowDescTfWidth = o.config.infoGameWindowDescTf.width;
				ConfigModel.infoGameWindowDescTfHeight = o.config.infoGameWindowDescTf.height;
				
				
				ConfigModel.allChipsPlayedTitle = o.config.allChipsPlayed.title;
				ConfigModel.allChipsPlayedText1 = o.config.allChipsPlayed.text_1;
				ConfigModel.allChipsPlayedText2 = o.config.allChipsPlayed.text_2;
				
				ConfigModel.allChipsCapturedTitle = o.config.allChipsCaptured.title;
				ConfigModel.allChipsCapturedText1 = o.config.allChipsCaptured.text_1;
				ConfigModel.allChipsCapturedText2 = o.config.allChipsCaptured.text_2;
				ConfigModel.allChipsCapturedText3 = o.config.allChipsCaptured.text_3;
				
				ConfigModel.tieGameTitle = o.config.tieGame.title;
				ConfigModel.tieGameText1 = o.config.tieGame.text_1;
				
				ConfigModel.neitherCanMakeMoveTitle = o.config.neitherCanMakeMove.title;
				ConfigModel.neitherCanMakeMoveText1 = o.config.neitherCanMakeMove.text_1;
				ConfigModel.neitherCanMakeMoveText2 = o.config.neitherCanMakeMove.text_2;
				ConfigModel.neitherCanMakeMoveText3 = o.config.neitherCanMakeMove.text_3;
				
				ConfigModel.noMoveAvailableTitle = o.config.noMoveAvailable.title;
				ConfigModel.noMoveAvailableText1 = o.config.noMoveAvailable.text_1;
				ConfigModel.noMoveAvailableText2 = o.config.noMoveAvailable.text_2;
				ConfigModel.noMoveAvailableText3 = o.config.noMoveAvailable.text_3;
				
				ConfigModel.toMapBtnFont = o.config.toMapBtn.font;
				ConfigModel.toMapBtnSize = o.config.toMapBtn.size;
				ConfigModel.toMapBtnText = o.config.toMapBtn.text;
				
				ConfigModel.rePlayBtnFont = o.config.rePlayBtn.font;
				ConfigModel.rePlayBtnSize = o.config.rePlayBtn.size;
				ConfigModel.rePlayBtnText = o.config.rePlayBtn.text;
				
				ConfigModel.comuterWaitTime = o.config.comuterWaitTime;
				
				configModel.assets = new Array();
				
				for each (var i:String in o.config.assets) 
				{
					configModel.assets.push(i);
				}
				
				Service.instance.configModel = configModel;
		}
	}
}