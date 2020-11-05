package 
{
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import starling.assets.AssetManager;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	/**
	 * ...
	 * @author Vendrie
	 */
	public class Game extends Sprite
	{
		private var assetsManager : AssetManager;
		
		private var blockPlayer : Image;
		private var obstacleArr: Vector.<Image> = new Vector.<Image>();
		
		private var jump : Boolean = false;
		private var speedUp : int;
		
		//private var timer : int = 30;
		
		public function Game() 
		{
			var appDir:File = File.applicationDirectory;
			//SET ASSETS MANAGER
			
			assetsManager = new AssetManager();
			assetsManager.enqueue(appDir.resolvePath("image"));
			
			assetsManager.loadQueue(startGame);
		}
		
		private function startGame():void {
			//create player
			blockPlayer = new Image(assetsManager.getTexture("block"));
			//obstacleItem = new Image(assetsManager.getTexture("circle"));
			blockPlayer.pivotY = blockPlayer.height;
			blockPlayer.x = 100;
			blockPlayer.y = 600;
			addChild(blockPlayer);

			//create Obstacle Items
			for (var i : int = 0; i < 5; i++) {
				var obstacleItem : Image = new Image(assetsManager.getTexture("circle"));
				obstacleItem.visible = false;
				obstacleItem.x = -100;
				obstacleItem.y = 0;
				addChild(obstacleItem);
				obstacleArr.push(obstacleItem);
			}

			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, upKeyboard);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:EnterFrameEvent):void 
		{
			
			if (jump == true) {
				blockPlayer.y -= speedUp;
				
				if (blockPlayer.y >= 601) {
					jump = false;
				}
				if (speedUp > -10) {
					speedUp--;
				}
			}
			
			
			
		}
		
		private function pressKeyboard(e:KeyboardEvent):void 
		{
			if (jump == true) return;
			if (e.keyCode == Keyboard.UP) 
			{
				jump = true;
				speedUp = 20;
			} 
			else if (e.keyCode == Keyboard.DOWN)
			{
				blockPlayer.scaleY = 0.5;
			}
		}
		
		private function upKeyboard(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.DOWN) {
				blockPlayer.scaleY = 1;
			}
		}
		
	}

}