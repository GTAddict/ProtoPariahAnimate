package PatrolStates 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class ShortSquareTRSpawn extends PatrolState 
	{
		private var numPoints:int = 4;
		
		public function ShortSquareTRSpawn(context:Robot) 
		{
			super(context);
		}
		
		override public function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= 1 / numPoints)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 3)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 4)
			{
				context.setDirection(Robot.RIGHT);
			}
		}
		
		protected override function pathInit():void
		{
			// Start
			path.addPoint(context.x, context.y);
			// Move down
			path.addPoint(context.x, context.y + 5 * TILE_SIZE);
			// Move left
			path.addPoint(context.x - 5 * TILE_SIZE, context.y + 5 * TILE_SIZE);
			// Move up
			path.addPoint(context.x - 5 * TILE_SIZE, context.y);
			// Move right
			path.addPoint(context.x, context.y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}

}