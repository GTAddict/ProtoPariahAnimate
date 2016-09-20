package PatrolStates 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class LargeUPatrol extends PatrolState 
	{
		private var numPoints:int = 20;
		
		public function LargeUPatrol(context:Robot) 
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 9)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 11)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 13)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 14)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 17)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 18)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 20)
			{
				context.setDirection(Robot.RIGHT);
			}
		}
		
		protected override function pathInit():void
		{
			var x:Number = context.x;
			var y:Number = context.y;
			// Origin
			path.addPoint(x, y);
			// Down 2
			path.addPoint(x, y + 2 * TILE_SIZE);
			// Left 7
			path.addPoint(x - 7 * TILE_SIZE, y + 2 * TILE_SIZE);
			// Up 2
			path.addPoint(x - 7 * TILE_SIZE, y);
			// Right 2
			path.addPoint(x - 5 * TILE_SIZE, y);
			// Down 1
			path.addPoint(x - 5 * TILE_SIZE, y + 1 * TILE_SIZE);
			// Right 3
			path.addPoint(x - 2 * TILE_SIZE, y + 1 * TILE_SIZE);
			// Up 1
			path.addPoint(x - 2 * TILE_SIZE, y);
			// Right 2
			path.addPoint(x, y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}

}