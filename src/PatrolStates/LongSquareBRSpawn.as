package PatrolStates 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class LongSquareBRSpawn extends PatrolState
	{
		private var numPoints:int = 4;
		
		public function LongSquareBRSpawn(context:Robot) 
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= 1 / numPoints)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 3)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 4)
			{
				context.setDirection(Robot.DOWN);
			}
		}
		
		protected override function pathInit():void
		{
			// Start
			path.addPoint(context.x, context.y);
			// Move left
			path.addPoint(context.x - 10 * TILE_SIZE, context.y);
			// Move up
			path.addPoint(context.x - 10 * TILE_SIZE, context.y - 10 * TILE_SIZE);
			// Move right
			path.addPoint(context.x, context.y - 10 * TILE_SIZE);
			// Move down
			path.addPoint(context.x, context.y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}

}