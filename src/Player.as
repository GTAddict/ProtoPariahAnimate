package 
{
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 * @author Dale Diaz
	 */
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity
	{	
		public var CURRENT_HEADING:Number;
		private var isAlive:Boolean = true;
		private var hasCompletedObjective:Boolean = false;
		private var inTerminal:Boolean = false;
		private var terminalController:TerminalController;
		
		
		private var upImg:Image;
		private var leftDownImg:Image; 
		private var rightDownImg:Image; 
		private var upLeftImg:Image; 
		private var upRightImg:Image; 
		private var downImg:Image; 
		private var leftImg:Image; 
		private var rightImg:Image; 
		
		private var inputController:PlayerInputController;
		private var terminalHandler:TerminalController;
		
		private var keyCardTarget:int 		= 0;
		private var keyCardsCollected:int 	= 0;
		
		[Embed(source = "../assets/Player_back_up.png")]			private const PLAYER_UP:Class;
		[Embed(source = "../assets/Player_diagnal_left_down.png")]	private const PLAYER_LEFT_DOWN:Class;
		[Embed(source = "../assets/Player_diagnal_right_down.png")]	private const PLAYER_RIGHT_DOWN:Class;
		[Embed(source = "../assets/Player_diagnal_up_left.png")]	private const PLAYER_UP_LEFT:Class;
		[Embed(source = "../assets/Player_diagnal_up_right.png")]	private const PLAYER_UP_RIGHT:Class;
		[Embed(source = "../assets/Player_front_down.png")]			private const PLAYER_DOWN:Class;
		[Embed(source = "../assets/Player_left.png")]				private const PLAYER_LEFT:Class;
		[Embed(source = "../assets/Player_right.png")]				private const PLAYER_RIGHT:Class;
		
		public function Player(detail:Array, w:Wall) 
		{
			layer = -10;		// Topmost
			this.x = detail[1];
			this.y = detail[2];
			
			upImg 			= new Image(PLAYER_UP);
			leftDownImg		= new Image(PLAYER_LEFT_DOWN);
			rightDownImg 	= new Image(PLAYER_RIGHT_DOWN);
			upLeftImg		= new Image(PLAYER_UP_LEFT);
			upRightImg 		= new Image(PLAYER_UP_RIGHT);
			downImg			= new Image(PLAYER_DOWN);
			leftImg 		= new Image(PLAYER_LEFT);
			rightImg 		= new Image(PLAYER_RIGHT);
			
			graphic = upImg;
			
			CURRENT_HEADING = PlayerInputController.HEADING_UP;
			
			inputController = new PlayerInputController(this, w);
			
			setHitbox(upImg.scaledWidth, upImg.scaledHeight);
			type = "Player";
			
			terminalController = new TerminalController(this);
			terminalController.updateEntityRefs();
		}
		
		override public function update():void
		{	
			terminalController.updateActiveTerminal();
			
			terminalController.updateEntityRefs();
			
			if (!inTerminal)
			{
				inputController.update();
			
				switch (CURRENT_HEADING)
				{
					case PlayerInputController.HEADING_DOWN:	
						graphic = downImg;
						break;
					case PlayerInputController.HEADING_UP:		
						graphic = upImg;										
						break;
					case PlayerInputController.HEADING_LEFT:	  
						graphic = leftImg; 	
						break;
					case PlayerInputController.HEADING_RIGHT:	
						graphic = rightImg; 	
						break;
					case PlayerInputController.HEADING_UP_LEFT:
						graphic = upLeftImg;
						break;
					case PlayerInputController.HEADING_UP_RIGHT:
						graphic = upRightImg;
						break;
					case PlayerInputController.HEADING_DOWN_LEFT:
						graphic = leftDownImg;
						break;
					case PlayerInputController.HEADING_DOWN_RIGHT:
						graphic = rightDownImg;
						break;
				}
				
				setHitbox((graphic as Image).scaledWidth, (graphic as Image).scaledHeight);
			}
			else
			{
				terminalController.update();
			}
			
		}
		
		// This is such a terrible hack I want to puke but we need to do this right now for the player getting stuck in the walls
		override public function hitTest(threshold:int, e:Entity, entityThreshold:int, x:Number, y:Number):Boolean
		{
			var hit:Boolean = false;
			
			if (e && e.graphic)
			{
				var playerPoint:Point = new Point(x, y);
				var entityPoint:Point = new Point(e.x, e.y);
				var bmData:BitmapData =e.graphic.getBuffer();
				
				hit = hit || downImg 		&& downImg		.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);
				hit = hit || upImg 			&& upImg		.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);
				hit = hit || leftImg 		&& leftImg		.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);
				hit = hit || rightImg		&& rightImg		.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);
				hit = hit || upLeftImg 		&& upLeftImg	.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);
				hit = hit || upRightImg 	&& upRightImg	.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);
				hit = hit || leftDownImg 	&& leftDownImg	.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);
				hit = hit || rightDownImg 	&& rightDownImg	.getBuffer().hitTest(playerPoint, threshold, bmData, entityPoint, entityThreshold);	
			}
			
			return hit;
		}
		
		public function IsAlive():Boolean
		{
			return isAlive;
		}
		
		public function SetAlive(alive:Boolean):void
		{
			isAlive = alive;
			
			if (!isAlive)
			{
				SoundEntity.playSound("DEATH");
			}
		}
		
		public function SetKeysToCollect(no:int):void
		{
			keyCardTarget = no;
		}
		
		public function HasCollectedKeys():Boolean
		{
			return keyCardsCollected == keyCardTarget;
		}
		
		public function OnKeyCollected():void
		{
			++keyCardsCollected;
		}
		
		public function HasCompletedObjective():Boolean
		{
			return hasCompletedObjective;
		}
		
		public function SetCompletedObjective(completed:Boolean):void
		{
			hasCompletedObjective = completed;
		}
		
		public function usingTerminal():Boolean
		{
			return inTerminal;
		}
		
		public function activateTerminal():void
		{
			inTerminal = true;
			trace("Terminal Activated");
		}
		
		public function deactivateTerminal():void
		{
			inTerminal = false;
			trace("Terminal Deactivated");
		}
		
		public function canAccessTerminal():Boolean
		{
			var activeTerminal:Terminal = terminalController.locateActiveTerminal();
			if (activeTerminal != null)
			{
				return activeTerminal.isAvailable();
			}
			return false;
		}
		
	}

}