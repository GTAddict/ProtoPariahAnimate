package PatrolStates
{
	/**
	 * @author Dale Diaz
	 */
	
	import adobe.utils.CustomActions;
	import net.flashpunk.tweens.motion.LinearPath;
	
	public class PatrolState
	{
		public static var SHORT_HORIZONTAL:int			= 0;
		public static var FIGURE_EIGHT:int     			= 1;
		public static var SERPENTINE:int       			= 2;
		public static var OMEGA:int            			= 3;
		public static var LONG_HORIZONTAL_RECTANGLE:int = 4;
		public static var LONG_SQUARE_BR:int			= 5;
		public static var LONG_VERTICAL_RECTANGLE:int	= 6;
		public static var FAT_L:int						= 7;
		public static var LONG_HORIZONTAL:int 			= 8;
		public static var LONG_VERTICAL:int   			= 9;
		public static var LARGE_U:int					= 10;
		public static var MEDIUM_VERTICAL_BOT_SPAWN:int = 11;
		public static var MEDIUM_VERTICAL_TOP_SPAWN:int = 12;
		public static var SHORT_SQUARE_BL_SPAWN:int 	= 13;
		public static var SHORT_SQUARE_TR_SPAWN:int		= 14;
		public static var SHORT_SQUARE:int     			= 15;
		public static var LONG_SQUARE:int				= 16;
		
		public static const WAIT_TIME:Number = 8;
		protected var TILE_SIZE:int = 32;
		protected var path:LinearPath;
		protected var context:Robot;
		
		public function PatrolState(context:Robot)
		{
			this.context = context;
			path = new LinearPath(reset);
			path.addPoint(context.x, context.y);
			pathInit();
			reset();
			path.setMotion(0);
			path.setMotionSpeed(context.getSpeed());
			path.object = context;
			context.addTween(path, true);
		}
		
		public function update():void
		{
			trace("updating generic patrol state");
		}
		
		protected virtual function pathInit():void
		{
			// Used in lower levels
		}
		
		// Used for resetting robot path
		protected virtual function reset():void
		{
			// should not be implemented at this level
		}
		
		public function getPoints():void
		{
			trace(path.pointCount);
		}
		
		public function stop():void
		{
			path.delay = WAIT_TIME;
		}
		
		public function start():void
		{
			//path.setMotionSpeed(context.getSpeed());
		}
	}
}