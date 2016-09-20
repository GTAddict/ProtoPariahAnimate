package PatrolStates 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class FatLPatrol extends PatrolState 
	{
		private var numPoints:int = 12;
		
		public function FatLPatrol(context:Robot) 
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
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 4)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 6)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 9)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 12)
			{
				context.setDirection(Robot.LEFT);
			}
		}
		
		protected override function pathInit():void
		{
			var x:Number = context.x;
			var y:Number = context.y;
	
			// Origin
			path.addPoint(x, y);
			// Up One
			path.addPoint(x, y - 1 * TILE_SIZE);
			// Right One
			path.addPoint(x + 1 * TILE_SIZE, y - 1 * TILE_SIZE);
			// Up Two
			path.addPoint(x + 1 * TILE_SIZE, y - 3 * TILE_SIZE );
			// Right Two
			path.addPoint(x + 3 * TILE_SIZE, y - 3 * TILE_SIZE);
			// Down Three
			path.addPoint(x + 3 * TILE_SIZE, y);
			// Left Three
			path.addPoint(x, y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}

}