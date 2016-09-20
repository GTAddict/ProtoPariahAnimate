package PatrolStates
{
	import adobe.utils.CustomActions;
	/**
	 * @author Dale Diaz
	 */
	
	public class FigureEightPatrol extends PatrolState
	{
		private var numPoints:int = 8;
		
		public function FigureEightPatrol(context:Robot):void
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			// trace("Delay: " + path.delay);
			// trace("Percent: " + percent);

			if (percent <= (1 / numPoints) * 1)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 3)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 4)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 5)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 6)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 7)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 8)
			{
				context.setDirection(Robot.UP);
			}
		}
		
		protected override function pathInit():void
		{
			var x:Number = context.x;
			var y:Number = context.y;
	
			// Origin
			path.addPoint(x, y);
			// Left Eight
			path.addPoint(x - 8 * TILE_SIZE, y);
			// Down Eight
			path.addPoint(x - 8 * TILE_SIZE, y + 8 * TILE_SIZE);
			// Left Eight
			path.addPoint(x - 16 * TILE_SIZE, y + 8 * TILE_SIZE);
			// Up Eight
			path.addPoint(x - 16 * TILE_SIZE, y);
			// Right Eight
			path.addPoint(x - 8 * TILE_SIZE, y);
			// Down Eight
			path.addPoint(x - 8 * TILE_SIZE, y + 8 * TILE_SIZE);
			// Right Eight
			path.addPoint(x, y + 8 * TILE_SIZE);
			// Up Eight
			path.addPoint(x, y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
	}
}