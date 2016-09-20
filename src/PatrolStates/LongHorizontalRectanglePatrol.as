package PatrolStates 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class LongHorizontalRectanglePatrol extends PatrolState 
	{
		private var numPoints:int = 16;
		
		public function LongHorizontalRectanglePatrol(context:Robot) 
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
			else if (percent <= (1 / numPoints) * 8)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 10)
			{
				context.setDirection(Robot.UP);

			}
			else if (percent <= (1 / numPoints) * 16)
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
			// Down 2
			path.addPoint(x, y + 2 * TILE_SIZE);
			// Right 6
			path.addPoint(x + 6 * TILE_SIZE, y + 2 * TILE_SIZE);
			// Up 2
			path.addPoint(x + 6 * TILE_SIZE, y);
			// Left 6
			path.addPoint(x, y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}

}