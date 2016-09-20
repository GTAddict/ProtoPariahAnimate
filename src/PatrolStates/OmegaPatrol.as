package PatrolStates
{
	
	public class OmegaPatrol extends PatrolState
	{
		
		// 11 points
		private var numPoints:int = 46;
		
		public function OmegaPatrol(context:Robot):void
		{
			super(context);
		}
		
		override public function update():void
		{
			if (path.percent <= (1 / numPoints) * 7)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (path.percent <= (1 / numPoints) * 10)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (path.percent <= (1 / numPoints) * 15)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (path.percent <= (1 / numPoints) * 20)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (path.percent <= (1 / numPoints) * 23)
			{
				context.setDirection(Robot.UP)
			}
			else if (path.percent <= (1 / numPoints) * 30)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (path.percent <= (1 / numPoints) * 33)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (path.percent <= (1 / numPoints) * 38)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (path.percent <= (1 / numPoints) * 43)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (path.percent <= (1 / numPoints) * 46)
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
			// Left seven
			path.addPoint(x - 7 * TILE_SIZE, y);
			// Down three
			path.addPoint(x - 7 * TILE_SIZE, y + 3 * TILE_SIZE);
			// Left five
			path.addPoint(x - 12 * TILE_SIZE, y + 3 * TILE_SIZE);
			// Right five
			path.addPoint(x - 7 * TILE_SIZE, y + 3 * TILE_SIZE);
			// Up three
			path.addPoint(x - 7 * TILE_SIZE, y);
			// Right seven
			path.addPoint(x, y);
			// Down three
			path.addPoint(x, y + 3 * TILE_SIZE);
			// Right five
			path.addPoint(x + 5 * TILE_SIZE, y + 3 * TILE_SIZE);
			// Left five
			path.addPoint(x, y + 3 * TILE_SIZE);
			// Up three
			path.addPoint(x, y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
	}
}