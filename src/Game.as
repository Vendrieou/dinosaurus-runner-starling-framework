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
		private var obstacleItemX:int = 0;
		private var obstacleItemY:int = 0;
		private var obstacleSpeed:int = 10;
		
		private var jump:Boolean = false;
		private var speedUp:int;
		
		private var timer:int = 30;
		private var score:TextField;
		
		//private var _starling : Starling;
		
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
			
			//var obstacleItem : Image = new Image(assetsManager.getTexture("circle"));
			//obstacleItem.x = 150;
			//obstacleItem.y = 475;
			////obstacleItem.y = 550;
			//addChild(obstacleItem);
			
			//create Obstacle Items
			for (var i:int = 0; i < 20; i++)
			{
				var obstacleItem:Image = new Image(assetsManager.getTexture("circle"));
				obstacleItem.visible = false;
				obstacleItem.x = 1024;
				obstacleItem.y = 0;
				addChild(obstacleItem);
				obstacleArr.push(obstacleItem);
			}
			
			//score = new TextField(150, 50);
			//score.x = 20;
			//score.y = 20;
			//score.text = "Score: 0";
			//addChild(score);
			//
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressKeyboard);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, upKeyboard);
			//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, pressRestartGame);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:EnterFrameEvent):void
		{
			
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
			// code obstacle
			timer--;
			if (timer <= 0)
			{
				timer = (Math.random() * 120) + 30;
				//timer = randomRange(-10, 10);
				
				for (var i:int = 0; i < obstacleArr.length; i++)
				{
					//if (obstacleArr[i].visible == false)
					//{
						obstacleArr[i].visible = true;
						obstacleItemX = obstacleArr[i].x;
						obstacleItemY = obstacleArr.length >= 60 ? 550 : 475;
						obstacleArr[i].y = obstacleItemY;
						//break;
					//}
					
					if (obstacleArr[j].visible == true){
						obstacleArr[j].x -= 100;
					}
					if (obstacleArr[j].visible == false){
						if (obstacleArr[j].x <= obstacleItemX){
							obstacleArr[j].visible = false;
						}
					}
					if (obstacleArr[j].bounds.intersects(blockPlayer.bounds) == true || obstacleArr[j].y >= 650)
					{
						score = new TextField(150, 50);
						score.x = this.stage.width / 2;
						score.y = this.stage.height / 2;
						//score.text = "Game Over Press 'R' to Restart Game";
						score.text = "Game Over";
						addChild(score);
						this.stage.starling.stop();
					}
				}
				
				//for (var j:int = 0; j < obstacleArr.length; j++)
				//{
					//
					//if (obstacleArr[j].visible == true){
						//obstacleArr[j].x -= 100;
					//}
					//if (obstacleArr[j].visible == false){
						//if (obstacleArr[j].x <= obstacleItemX){
							//obstacleArr[j].visible = false;
						//}
					//}
					//if (obstacleArr[j].bounds.intersects(blockPlayer.bounds) == true || obstacleArr[j].y >= 650)
					//{
						//score = new TextField(150, 50);
						//score.x = this.stage.width / 2;
						//score.y = this.stage.height / 2;
						////score.text = "Game Over Press 'R' to Restart Game";
						//score.text = "Game Over";
						//addChild(score);
						//this.stage.starling.stop();
					//}
					//
					//
					//
					////if (obstacleArr[j].visible == true)
					////{
						////obstacleArr[j].x -= 5;
							//////obstacleArr[j].x = this.stage.width - randomRange(200, 800);
					////}
					//
					////if (obstacleArr[j].bounds.intersects(blockPlayer.bounds) == true || obstacleArr[j].y >= 650)
					////{
						////obstacleArr[j].y = -100;
						////obstacleArr[j].visible = false;
						////
						////score = new TextField(150, 50);
						////score.x = this.stage.width / 2;
						////score.y = this.stage.height / 2;
						//////score.text = "Game Over Press 'R' to Restart Game";
						////score.text = "Game Over";
						////addChild(score);
						////this.stage.starling.stop();
					////}
					//
					////if (obstacleArr[j].y >= 650)
					////{
						////obstacleArr[j].y = -100;
						////obstacleArr[j].visible = false;
					////}
				//}
			}
		
			//score = new TextField(150, 50);
			//score.x = 20;
			//score.y = 20;
			//score.text = "Score: " + obstacleArr.length;
			////score.text = "Score: " + (obstacleArr[0].visible == false);
			////score.text = "Score: " +  (timer <= 0);
			//addChild(score);
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
	
		//private function randomRange(minNum:Number, maxNum:Number):Number
		//{
		//return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		//}
	
		//private function pressRestartGame(e:KeyboardEvent):void
		//{
		//if (e.charCode == 82)
		//{
		//this.stage.starling.start();
		//}
		//}
	
	}

}