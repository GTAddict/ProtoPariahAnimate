package 
{
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	public class PlayerInputController extends Input
	{
		private var playerRef:Player;
		private const WALK_SPEED:Number = 250;				// 250 pixels per second
		
		private const KEYBINDING_MOVE_LEFT:int 	= Key.A;
		private const KEYBINDING_MOVE_RIGHT:int = Key.D;
		private const KEYBINDING_MOVE_UP:int 	= Key.W;
		private const KEYBINDING_MOVE_DOWN:int 	= Key.S;
		
		private const KEYBINDING_MOVE_LEFT_ALTERNATE:int 	= Key.LEFT;
		private const KEYBINDING_MOVE_RIGHT_ALTERNATE:int 	= Key.RIGHT;
		private const KEYBINDING_MOVE_UP_ALTERNATE:int 		= Key.UP;
		private const KEYBINDING_MOVE_DOWN_ALTERNATE:int 	= Key.DOWN;
		
		public static const HEADING_LEFT:Number  		= 0;
		public static const HEADING_RIGHT:Number 		= 1;
		public static const HEADING_UP:Number    		= 2;
		public static const HEADING_DOWN:Number  		= 3;
		public static const HEADING_UP_LEFT:Number		= 4;
		public static const HEADING_UP_RIGHT:Number		= 5;
		public static const HEADING_DOWN_LEFT:Number	= 6;
		public static const HEADING_DOWN_RIGHT:Number	= 7;
		
		private var wallRef:Wall;
		
		public function PlayerInputController(player:Player, w:Wall)
		{
			playerRef = player;
			wallRef = w;
		}
		
		public function update():void
		{
			var deltaTime:Number = FP.elapsed;
			var deltaPos:Number = deltaTime * WALK_SPEED;
			
			var keycard:Keycard = playerRef.collide("Keycard", playerRef.x, playerRef.y) as Keycard;
			if (keycard)
			{
				SoundEntity.playSound("COLLECT");
				
				if (keycard.getIsChip())
				{
					playerRef.SetCompletedObjective(true);
				}
				playerRef.OnKeyCollected();
				FP.world.remove(keycard);
			}
			
			// Since CameraBots can't be deactivated, we go ahead
			if (playerRef.collide("CameraBot", playerRef.x, playerRef.y))
			{
				playerRef.SetAlive(false);
				return;
			}
			
			
			var newX:Number = playerRef.x;
			var newY:Number = playerRef.y;
			
			// Pre-calculate what the X and Y are going to be.
			// Once that's done do a collision test. Move
			// character only if there's going to be no collision.
			
			if (check(KEYBINDING_MOVE_LEFT) || check(KEYBINDING_MOVE_LEFT_ALTERNATE))
			{
				newX = playerRef.x - deltaPos;
				playerRef.CURRENT_HEADING = HEADING_LEFT;
				
			}
			
			if (check(KEYBINDING_MOVE_RIGHT) || check(KEYBINDING_MOVE_RIGHT_ALTERNATE))
			{
				newX = playerRef.x + deltaPos;
				playerRef.CURRENT_HEADING = HEADING_RIGHT;
				
			}
			
			if (check(KEYBINDING_MOVE_UP) || check(KEYBINDING_MOVE_UP_ALTERNATE))
			{
				newY = playerRef.y - deltaPos;
				playerRef.CURRENT_HEADING = HEADING_UP;
				
			}
			
			if (check(KEYBINDING_MOVE_DOWN) || check(KEYBINDING_MOVE_DOWN_ALTERNATE))
			{
				newY = playerRef.y + deltaPos;
				playerRef.CURRENT_HEADING = HEADING_DOWN;
			}
			
			if (wallRef && playerRef)
			{
				// Check collisions with walls
				if (playerRef.hitTest(0, wallRef, 255, newX, playerRef.y))
				{
					newX = playerRef.x;
				}
				
				if (playerRef.hitTest(0, wallRef, 255, playerRef.x, newY))
				{
					newY = playerRef.y;
				}
			}
			
			var Collided:Boolean = false;
		
			if (playerRef.collide("Terminal", newX, playerRef.y))
			{
				newX = playerRef.x;
				Collided = true;
			}
			
			if (playerRef.collide("Terminal", playerRef.x, newY))
			{
				newY = playerRef.y;
				Collided = true;
			}
			
			if (Collided && !playerRef.usingTerminal() && playerRef.canAccessTerminal())
			{
				playerRef.activateTerminal();
			}
			
			if (playerRef.HasCollectedKeys())
			{
				if (playerRef.collide("ExitDoor", playerRef.x, playerRef.y))
				{
					playerRef.SetCompletedObjective(true);
					return;	
				}
			}
			else		// We don't want him walking through the door 
			{	
				if (playerRef.collide("ExitDoor", newX, playerRef.y))
				{
					newX = playerRef.x;
				}
			
				if (playerRef.collide("ExitDoor", playerRef.x, newY))
				{
					newY = playerRef.y;
				}
			}
			
			// And don't let him walk through the entry door, ever
			if (playerRef.collide("EntranceDoor", newX, playerRef.y))
			{
				newX = playerRef.x;
			}
			
			if (playerRef.collide("EntranceDoor", playerRef.x, newY))
			{
				newY = playerRef.y;
			}
			
			var robot:Robot = playerRef.collide("Robot", newX, playerRef.y) as Robot;
			if (robot)
			{
				if (robot.isActivated())
				{
						playerRef.SetAlive(false);
						return;
				}
				else
				{
					newX = playerRef.x;
				}
			}
			
			robot = playerRef.collide("Robot", playerRef.x, newY) as Robot;
			if (robot)
			{
				if (robot.isActivated())
				{
					playerRef.SetAlive(false);
					return;
				}
				else
				{
					newY = playerRef.y;
				}
			}
			
			var xHeading:Number = -1;
			var yHeading:Number = -1;
			
			if ((newX - playerRef.x) > 0)	{ xHeading = HEADING_RIGHT; } 	else if ((newX - playerRef.x) < 0)	{ xHeading = HEADING_LEFT; }
			if ((newY - playerRef.y) > 0)	{ yHeading = HEADING_DOWN; } 	else if ((newY - playerRef.y) < 0)	{ yHeading = HEADING_UP; }
			
			if (xHeading == HEADING_RIGHT && yHeading == HEADING_DOWN)
			{
				playerRef.CURRENT_HEADING = HEADING_DOWN_RIGHT;
			}
			else if (xHeading == HEADING_RIGHT && yHeading == HEADING_UP)
			{
				playerRef.CURRENT_HEADING = HEADING_UP_RIGHT;
			}
			else if (xHeading == HEADING_LEFT && yHeading == HEADING_DOWN)
			{
				playerRef.CURRENT_HEADING = HEADING_DOWN_LEFT;
			}
			else if (xHeading == HEADING_LEFT && yHeading == HEADING_UP)
			{
				playerRef.CURRENT_HEADING = HEADING_UP_LEFT;
			}
			else if (xHeading == HEADING_LEFT || xHeading == HEADING_RIGHT)
			{
				playerRef.CURRENT_HEADING = xHeading;
			}
			else if (yHeading == HEADING_UP || yHeading == HEADING_DOWN)
			{
				playerRef.CURRENT_HEADING = yHeading;
			}
			
			playerRef.x = newX;
			playerRef.y = newY;
			
		}
		
	}

}