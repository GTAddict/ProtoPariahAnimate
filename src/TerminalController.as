package 
{
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class TerminalController extends Input 
	{
		
		private var terminals:Array;
		private var playerRef:Player;
		private var robots:Array;
		private var currentRobotSelection:int;
		private var activeTerminal:Terminal
		private var terminalsInitialized:Boolean = false;
		private var firstUpdate:Boolean = true;
		
		public function TerminalController(playerRef:Player) 
		{
			terminals = new Array();
			robots = new Array();
			FP.world.getType("Terminal", terminals);
			FP.world.getType("Robot", robots);
			trace("terminal size: " + terminals.length);
			trace("robot size: " + robots.length);
			this.playerRef = playerRef;
			currentRobotSelection = 0;
		}
		
		public function update():void
		{
			if (firstUpdate)
			{
				updateEntityRefs();
				firstUpdate = false;
			}
			
			activeTerminal = locateActiveTerminal();

			
			if (!terminalsInitialized && terminals.length == 0)
			{
				updateEntityRefs();
				if (terminals.length != 0)
				{
					terminalsInitialized = true;
				}
			}
			
			if (currentRobotSelection >=0 && robots[currentRobotSelection].isActivated())
			{
				robots[currentRobotSelection].select();
			}
			
			if (pressed(Key.ESCAPE))
			{
				playerRef.deactivateTerminal();
				if (currentRobotSelection > 0)
				{
					robots[currentRobotSelection].deselect();
				}
			}
			else if (pressed(Key.A) || pressed(Key.LEFT))
			{
				if (currentRobotSelection >= 0)
				{
					robots[currentRobotSelection].deselect();
				}
				
				currentRobotSelection--;
				
				if (currentRobotSelection < 0)
				{
					currentRobotSelection = robots.length - 1;
				}
				
				while (currentRobotSelection >= 0 && currentRobotSelection < robots.length && 
				!robots[currentRobotSelection].isActivated())
				{
					currentRobotSelection++;
				}
				
				if (currentRobotSelection >= 0 && currentRobotSelection < robots.length)
				{
					robots[currentRobotSelection].select();
				}
				
			}
			else if (pressed(Key.D) || pressed(Key.RIGHT))
			{
				if (currentRobotSelection >= 0)
				{
					robots[currentRobotSelection].deselect();
				}
				
				currentRobotSelection++;
				
				if (currentRobotSelection >= robots.length)
				{
					currentRobotSelection = 0;
				}
				
				while (currentRobotSelection >= 0 && currentRobotSelection < robots.length && 
				!robots[currentRobotSelection].isActivated())
				{
					currentRobotSelection++;
					if (currentRobotSelection > robots.length - 1)
					{
						currentRobotSelection = -1;
					}
				}
				
				if (currentRobotSelection >= 0)
				{
					robots[currentRobotSelection].select();
				}
			}
			else if (pressed(Key.E) || pressed(Key.ENTER))
			{
				SoundEntity.playSound("OFF");
				robots[currentRobotSelection].deselect();
				robots[currentRobotSelection].turnOff();
				playerRef.deactivateTerminal();
				activeTerminal.deactivate();
				robots[currentRobotSelection].pairWithTerminal(activeTerminal);
			}

		}
		
		public function locateActiveTerminal():Terminal
		{
			var distance:Number;
			var closestDistance:Number = -1;
			var closestIndex:int = -1;
			var i:int;
			for (i = 0; i < terminals.length; i++)
			{
				distance = Math.abs(playerRef.x - terminals[i].x) + 
						   Math.abs(playerRef.y - terminals[i].y);
				if (distance < closestDistance || closestDistance == -1)
				{
					distance = closestDistance;
					closestIndex = i;
				}
			}
			
			return terminals[closestIndex] as Terminal;
		}
		
		public function updateActiveTerminal():void
		{
			activeTerminal = locateActiveTerminal();
		}
		
		private function updateRobots():void
		{
			robots = new Array();
			FP.world.getType("Robot", robots);
		}
		
		public function updateEntityRefs():void
		{
			FP.world.getType("Terminal", terminals);
			FP.world.getType("Robot", robots);
		}
		
	}

}