package PatrolStates 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class LongVerticalRectanglePatrol extends PatrolState 
	{
		private var numPoints:int = 24;
		
		public function LongVerticalRectanglePatrol(context:Robot) 
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 12)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 14)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 24)
			{
				context.setDirection(Robot.DOWN);
			}
		}
		
		protected override function pathInit():void
		{
			var x:Number = context.x;
			var y:Number = context.y;
			// Origin
			path.addPoint(x, y);
			// Left 2
			path.addPoint(x - 2 * TILE_SIZE, y);
			// Up 10
			path.addPoint(x - 2 * TILE_SIZE, y - 10 * TILE_SIZE);
			// Right 2
			path.addPoint(x, y - 10 * TILE_SIZE);
			// Down 10
			path.addPoint(x, y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}

}