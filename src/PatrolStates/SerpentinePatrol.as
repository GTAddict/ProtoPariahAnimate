package PatrolStates
{
	/**
	 * @author Dale Diaz
	 */
	
	public class SerpentinePatrol extends PatrolState
	{
		private var numPoints:int = 12;
		
		public function SerpentinePatrol(context:Robot):void
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
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
				context.setDirection(Robot.RIGHT)
			}
			else if (percent <= (1 / numPoints) * 4)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 5)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 6)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 7)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 8)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 9)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 10)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 11)
			{
				context.setDirection(Robot.RIGHT);
			}
		}
		
		protected override function pathInit():void
		{
			// Origin
			path.addPoint(context.x, context.y);
			// Left
			path.addPoint(context.x - 2 * TILE_SIZE, context.y);
			// Down
			path.addPoint(context.x - 2 * TILE_SIZE, context.y + 2 * TILE_SIZE);
			// Right
			path.addPoint(context.x, context.y + 2 * TILE_SIZE);
			// Down
			path.addPoint(context.x, context.y + 4 * TILE_SIZE);
			// Left
			path.addPoint(context.x - 2 * TILE_SIZE, context.y + 4 * TILE_SIZE);
			// Right
			path.addPoint(context.x, context.y + 4 * TILE_SIZE);
			// Up
			path.addPoint(context.x, context.y + 2 * TILE_SIZE);
			// Left
			path.addPoint(context.x - 2 * TILE_SIZE, context.y + 2 * TILE_SIZE);
			// Up
			path.addPoint(context.x - 2 * TILE_SIZE, context.y);
			// Right
			path.addPoint(context.x, context.y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
	}
}