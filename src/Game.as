package
{
	import flash.filesystem.File;
	import flash.ui.Keyboard;
	import starling.assets.AssetManager;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
	//import starling.core.Starling;
	
	/**
	 * ...
	 * @author Vendrie
	 */
	public class Game extends Sprite
	{
		private var assetsManager:AssetManager;
		
		private var blockPlayer:Image;
		private var obstacleArr:Vector.<Image> = new Vector.<Image>();
		private var obstacleItemY:int = 0;
		private var obstacleSpeed:int = 10;
		
		private var jump:Boolean = false;
		private var speedUp:int;
		
		private var timer:int = 30;
		private var GameOverText:TextField;
		private var scoreText:TextField;
		private var score:int = 0;
		
		public function Game()
		{
			var appDir:File = File.applicationDirectory;
			//SET ASSETS MANAGER
			
			assetsManager = new AssetManager();
			assetsManager.enqueue(appDir.resolvePath("image"));
			
			assetsManager.loadQueue(startGame);
		}
		
		private function startGame():void
		{
			//create player
			blockPlayer = new Image(assetsManager.getTexture("block"));
			blockPlayer.pivotY = blockPlayer.height;
			blockPlayer.x = 100;
			blockPlayer.y = 600;
			addChild(blockPlayer);
			
			//create Obstacle Items
			for (var i:int = 0; i < 1; i++)
			{
				var obstacleItem:Image = new Image(assetsManager.getTexture("circle"));
				obstacleItem.visible = false;
				obstacleItem.x = 1024;
				obstacleItem.y = 0;
				addChild(obstacleItem);
				obstacleArr.push(obstacleItem);
			}
			
			scoreText = new TextField(150, 50);
			scoreText.x = 20;
			scoreText.y = 20;
			scoreText.text = "Score: 0";
			addChild(scoreText);
			
			GameOverText = new TextField((this.stage.width / 2), (this.stage.height / 2));
			addChild(GameOverText);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, upKeyboard);
			//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressRestartGame);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:EnterFrameEvent):void
		{
			scoreText.text = "Score: " + score;
			addChild(scoreText);
			
			if (jump == true)
			{
				blockPlayer.y -= speedUp;
				
				if (blockPlayer.y >= 601)
				{
					jump = false;
				}
				if (speedUp > -10)
				{
					speedUp--;
				}
			}

			// code obstacles
				for (var i:int = 0; i < obstacleArr.length; i++)
				{
					if (obstacleArr[i].visible == false)
					{
						obstacleArr[i].visible = true;
						obstacleItemY = 550;
						obstacleArr[i].y = obstacleItemY;
					}
					
					if (obstacleArr[i].visible == true){
						obstacleArr[i].x -= 5;
					}
					
					// auto JUMP & DUCK from Obstacles
					//--start--
					if (obstacleArr[i].y == 550 && obstacleArr[i].x <= 150)
					{
						jump = true;
						speedUp = 20;
						blockPlayer.scaleY = 1;
						blockPlayer.y = 475;
					}
					else if (obstacleArr[i].y == 475 && obstacleArr[i].x <= 150) 
					{
						blockPlayer.scaleY = 0.5;
					} 
					if (obstacleArr[i].x <= 0) {
						blockPlayer.scaleY = 1;	 
					}
					//--end--
			
					// add score after pass obstacle
					if (obstacleArr[i].x <= 0){
						obstacleArr[i].x = this.stage.width + randomRange(200, 800);
						// get random position obstacles
						obstacleArr[i].y = randomRange(1, 2) % 2 == 0 ? 475 : 550;
						score++;
					}
				
					// show game over and stop enterFrame process
					if (obstacleArr[i].bounds.intersects(blockPlayer.bounds) == true || obstacleArr[i].y >= 650)
					{
						//GameOverText.text = "Game Over Press 'R' to Restart Game";
						GameOverText.text = "Game Over";
						this.stage.starling.stop();
					}
				}
				addChild(GameOverText);
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
			if (e.keyCode == Keyboard.DOWN)
			{
				blockPlayer.scaleY = 1;
			}
		}
	
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	
		//private function pressRestartGame():void
		//{
			//if (e.keyCode.toString() == '82')
				//this.stage.starling.start();
			//}
		//}
	
	}

}