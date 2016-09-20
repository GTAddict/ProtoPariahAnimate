package 
{
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 * @author Dale Diaz
	 */
	import PatrolStates.FatLPatrol;
	import PatrolStates.FigureEightPatrol;
	import PatrolStates.LargeUPatrol;
	import PatrolStates.LongHorizontalPatrol;
	import PatrolStates.LongHorizontalRectanglePatrol;
	import PatrolStates.LongSquarePatrol;
	import PatrolStates.LongVerticalPatrol;
	import PatrolStates.LongVerticalRectanglePatrol;
	import PatrolStates.MediumVerticalBotSpawnPatrol;
	import PatrolStates.MediumVerticalTopSpawnPatrol;
	import PatrolStates.OmegaPatrol;
	import PatrolStates.PatrolState;
	import PatrolStates.SerpentinePatrol;
	import PatrolStates.ShortHorizontalPatrol;
	import PatrolStates.ShortSquareBLSpawn;
	import PatrolStates.ShortSquarePatrol;
	import PatrolStates.ShortSquareTRSpawn;
	import PatrolStates.LongSquareBRSpawn;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Robot extends Entity
	{
		[Embed(source = "../assets/Robot_active_glow_left.png")]	private const ROBOT_GLOW_LEFT:Class;
		[Embed(source = "../assets/Robot_active_glow_right.png")]	private const ROBOT_GLOW_RIGHT:Class;
		[Embed(source = "../assets/Robot_active_left.png")]			private const ROBOT_ACTIVE_LEFT:Class;
		[Embed(source = "../assets/Robot_active_right.png")]		private const ROBOT_ACTIVE_RIGHT:Class;
		[Embed(source = "../assets/Robot_sleep_left.png")]			private const ROBOT_SLEEP_LEFT:Class;
		[Embed(source = "../assets/Robot_sleep_right.png")]			private const ROBOT_SLEEP_RIGHT:Class;
		[Embed(source = "../assets/Robot_active_back_up.png")]		private const ROBOT_ACTIVE_UP:Class;
		[Embed(source = "../assets/Robot_active_front_down.png")]	private const ROBOT_ACTIVE_DOWN:Class;
		[Embed(source = "../assets/Robot_active_glowing_back_up.png")] private const ROBOT_GLOWING_UP:Class;
		[Embed(source = "../assets/Robot_active_glow_front_down.png")] private const ROBOT_GLOWING_DOWN:Class;
		[Embed(source = "../assets/Robot_sleep_back_up.png")] private const ROBOT_SLEEP_UP:Class;
		[Embed(source = "../assets/Robot_sleep_front_down.png")] private const ROBOT_SLEEP_DOWN:Class;
		
		public static const UP:int = 0;
		public static const DOWN:int = 1;
		public static const LEFT:int = 2;
		public static const RIGHT:int = 3;
		private var direction:int;
		
		private const slowSpeed:int = 100;
		private const mediumSpeed:int = 200;
		private const fastSpeed:int = 300;
		
		private var speed:int;
		
		private var glowLeftImg:Image; 	 
		private var glowRightImg:Image; 
		protected var activeLeftImg:Image;
		protected var activeRightImg:Image;
		private var sleepLeftImg:Image;
		private var sleepRightImg:Image;
		protected var activeUpImg:Image;
		protected var activeDownImg:Image;
		private var glowUpImg:Image;
		private var glowDownImg:Image;
		private var sleepDownImg:Image;
		private var sleepUpImg:Image;
		
		private var patrolState:PatrolState;
		
		private const ShortHorizontalPattern:RegExp 		= /ShortHorizontal/;
		private const ShortSquarePattern:RegExp 			= /ShortSquare/;
		private const FigureEightPattern:RegExp 			= /FigureEight/;
		private const SerpentinePattern:RegExp 				= /Serpentine/;
		private const OmegaPattern:RegExp 					= /Omega/;
		private const LongHorizontalRectanglePattern:RegExp = /LongHorizontalRectangle/;
		private const LongSquareBRSpawnPattern:RegExp		= /LongSquareBRSpawn/;
		private const LongVerticalRectanglePattern:RegExp 	= /LongVerticalRectangle/;
		private const FatLPattern:RegExp					= /FatL/;
		private const LongHorizontalPattern:RegExp  		= /LongHorizontal/;
		private const LongVerticalPattern:RegExp			= /LongVertical/;
		private const LargeUPattern:RegExp					= /LargeU/;
		private const MediumVerticalBotSpawnPattern:RegExp	= /MediumVerticalBotSpawn/;
		private const MediumVerticalTopSpawnPattern:RegExp	= /MediumVerticalTopSpawn/;
		private const ShortSquareBLSpawnPattern:RegExp		= /ShortSquareBLSpawn/;
		private const ShortSquareTRSpawnPattern:RegExp		= /ShortSquareTRSpawn/;
		private const LongSquarePattern:RegExp				= /LongSquare/;
		
		private const SlowSpeedPattern:RegExp				= /Slow/;
		private const MediumSpeedPattern:RegExp				= /Medium/;
		private const FastSpeedPattern:RegExp				= /Fast/;
		
		private var selected:Boolean;
		private var isActive:Boolean;
		
		private var pairedTerminal:Terminal = null;
		
		private var shutdownTimer:Timer;
		
		// Construtor with no specified patrol state. Defaults to short horizontal
		public function Robot(detail:Array) 
		{
			this.x = detail[1];
			this.y = detail[2];
			
			if (SlowSpeedPattern.exec(detail[0]))
			{
				this.speed = slowSpeed;
			}
			else if (MediumSpeedPattern.exec(detail[0]))
			{
				this.speed = mediumSpeed;
			}
			else if (FastSpeedPattern.exec(detail[0]))
			{
				this.speed = fastSpeed;
			}
			else
			{
				this.speed = mediumSpeed;
			}
			
			pairedTerminal = null;
			
			if (ShortHorizontalPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.SHORT_HORIZONTAL);
			}
			else if (FigureEightPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.FIGURE_EIGHT);
			}
			else if (SerpentinePattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.SERPENTINE);
			}
			else if (OmegaPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.OMEGA);
			}
			else if (LongHorizontalRectanglePattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LONG_HORIZONTAL_RECTANGLE);
			}
			else if (LongSquareBRSpawnPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LONG_SQUARE_BR);
			}
			else if (LongVerticalRectanglePattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LONG_VERTICAL_RECTANGLE);
			}
			else if (FatLPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.FAT_L);
			}
			else if (LongHorizontalPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LONG_HORIZONTAL);
			}
			else if (LongVerticalPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LONG_VERTICAL);
			}
			else if (LongVerticalRectanglePattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LONG_VERTICAL);
			}
			else if (LargeUPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LARGE_U);
			}
			else if (MediumVerticalBotSpawnPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.MEDIUM_VERTICAL_BOT_SPAWN);
			}
			else if (MediumVerticalTopSpawnPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.MEDIUM_VERTICAL_TOP_SPAWN);
			}
			else if (ShortSquareBLSpawnPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.SHORT_SQUARE_BL_SPAWN);
			}
			else if (ShortSquareTRSpawnPattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.SHORT_SQUARE_TR_SPAWN);
			}
			else if (ShortSquarePattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.SHORT_SQUARE);
			}
			else if (LongSquarePattern.exec(detail[0]))
			{
				setPatrolState(PatrolState.LONG_SQUARE);
			}
			
			direction = LEFT;
			
			setTextures();
			
			graphic = activeLeftImg;
			
			selected = false;
			isActive = true;
			shutdownTimer = new Timer(1000);
			shutdownTimer.addEventListener(TimerEvent.TIMER, robotShutdownSequence);

			setHitbox(activeLeftImg.scaledWidth, activeLeftImg.scaledHeight);
			
			setType();
		}
		
		public function setTextures():void
		{
			glowLeftImg 	= new Image(ROBOT_GLOW_LEFT);
			glowRightImg 	= new Image(ROBOT_GLOW_RIGHT);
			activeLeftImg 	= new Image(ROBOT_ACTIVE_LEFT);
			activeRightImg 	= new Image(ROBOT_ACTIVE_RIGHT);
			sleepLeftImg 	= new Image(ROBOT_SLEEP_LEFT);
			sleepRightImg 	= new Image(ROBOT_SLEEP_RIGHT);
			activeUpImg 	= new Image(ROBOT_ACTIVE_UP);
			activeDownImg 	= new Image(ROBOT_ACTIVE_DOWN);
			glowUpImg		= new Image(ROBOT_GLOWING_UP);
			glowDownImg 	= new Image(ROBOT_GLOWING_DOWN);
			sleepUpImg      = new Image(ROBOT_SLEEP_UP);
			sleepDownImg	= new Image(ROBOT_SLEEP_DOWN);
		}
		
		public function setType():void
		{
			type = "Robot";
		}
		
		public function robotShutdownSequence(e:TimerEvent):void
		{
			var seconds:Number = shutdownTimer.currentCount;
			trace(seconds);
			if (seconds >= PatrolState.WAIT_TIME)
			{
				turnOn();
				shutdownTimer.reset();
				shutdownTimer.stop();
				pairedTerminal.activate(); // Resets terminal to active state
				pairedTerminal = null; // Detatch terminal
			}
		}
		
		public function turnOn():void
		{
			SoundEntity.playSound("ROBOTON");
			isActive = true;
		}
		
		public function turnOff():void
		{
			SoundEntity.playSound("ROBOTON");
			isActive = false;
			patrolState.stop();
			shutdownTimer.start();
		}
		
		override public function update():void
		{
			updatePatrolState();
			updateGraphic();
		}
		
		private function updateGraphic():void
		{
			switch (direction)
			{
				case LEFT:
					if (selected)
					{
						graphic = glowLeftImg;
					}
					else 
					{
						if (isActive)
						{
							graphic = activeLeftImg;
						}
						else
						{
							graphic = sleepLeftImg;
						}
					}
					break;
				case RIGHT:
					if (selected)
					{
						graphic = glowRightImg;
					}
					else
					{
						if (isActive)
						{
							graphic = activeRightImg;
						}
						else
						{
							graphic = sleepRightImg;
						}
					}
					break;
				case UP:
					if (selected)
					{
						graphic = glowUpImg;
					}
					else
					{
						if (isActive)
						{
							graphic = activeUpImg;
						}
						else
						{
							graphic = sleepUpImg;
						}
					}
					break;
				case DOWN:
					if (selected)
					{
						graphic = glowDownImg;
					}
					else
					{
						if (isActive)
						{
							graphic = activeDownImg;
						}
						else
						{
							graphic = sleepDownImg;
						}
					}
					break;
			}
			
			setHitbox((graphic as Image).scaledWidth, (graphic as Image).scaledHeight);
		}
		
		public function getSpeed():int
		{
			return speed;
		}
		
		public function select():void
		{
			selected = true;
		}
		
		public function deselect():void
		{
			selected = false;
		}
		
		public function setDirection(direction:int):void
		{
			this.direction = direction;
		}
		
		public function isActivated():Boolean
		{
			return this.isActive;
		}
		
		private function updatePatrolState():void
		{
			patrolState.update();
		}
		
		public function setPatrolState(newState:int):void
		{
			switch (newState)
			{
				case PatrolState.SHORT_HORIZONTAL:
					this.patrolState = new ShortHorizontalPatrol(this) as ShortHorizontalPatrol;
					break;
				case PatrolState.FIGURE_EIGHT:
					this.patrolState = new FigureEightPatrol(this) as FigureEightPatrol;
					break;
				case PatrolState.SERPENTINE:
					this.patrolState = new SerpentinePatrol(this) as SerpentinePatrol;
					break;
				case PatrolState.OMEGA:
					this.patrolState = new OmegaPatrol(this) as OmegaPatrol;
					break;
				case PatrolState.LONG_HORIZONTAL:
					this.patrolState = new LongHorizontalPatrol(this) as LongHorizontalPatrol;
					break;
				case PatrolState.LONG_SQUARE_BR:
					this.patrolState = new LongSquareBRSpawn(this) as LongSquareBRSpawn;
					break;
				case PatrolState.LONG_VERTICAL:
					this.patrolState = new LongVerticalPatrol(this) as LongVerticalPatrol;
					break;
				case PatrolState.FAT_L:
					this.patrolState = new FatLPatrol(this) as FatLPatrol;
					break;
				case PatrolState.LONG_HORIZONTAL_RECTANGLE:
					this.patrolState = 
					new LongHorizontalRectanglePatrol(this) as LongHorizontalRectanglePatrol;
					break;
				case PatrolState.LONG_VERTICAL_RECTANGLE:
					this.patrolState = 
					new LongVerticalRectanglePatrol(this) as LongVerticalRectanglePatrol;
					break;
				case PatrolState.LARGE_U:
					this.patrolState = new LargeUPatrol(this) as LargeUPatrol;
					break;
				case PatrolState.MEDIUM_VERTICAL_BOT_SPAWN:
					this.patrolState = 
					new MediumVerticalBotSpawnPatrol(this) as MediumVerticalBotSpawnPatrol;
					break;
				case PatrolState.MEDIUM_VERTICAL_TOP_SPAWN:
					this.patrolState = 
					new MediumVerticalTopSpawnPatrol(this) as MediumVerticalTopSpawnPatrol;
					break;
				case PatrolState.SHORT_SQUARE_BL_SPAWN:
					this.patrolState = new ShortSquareBLSpawn(this) as ShortSquareBLSpawn;
					break;
				case PatrolState.SHORT_SQUARE_TR_SPAWN:
					this.patrolState = new ShortSquareTRSpawn(this) as ShortSquareTRSpawn;
					break;
				case PatrolState.SHORT_SQUARE:
					this.patrolState = new ShortSquarePatrol(this) as ShortSquarePatrol;
					break;
				case PatrolState.LONG_SQUARE:
					this.patrolState = new LongSquarePatrol(this) as LongSquarePatrol;
					break;
			}
		}
		
		public function pairWithTerminal(pairedTerminal:Terminal):void
		{
			this.pairedTerminal = pairedTerminal;
		}
		
	}

}
