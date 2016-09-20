package PatrolStates
{
	/**
	 * @author Dale Diaz
	 */
	public class LongVerticalPatrol extends PatrolState
	{
		private var numPoints:int = 2;
		
		public function LongVerticalPatrol(context:Robot):void
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= (1 / numPoints) * 1)
			{
				context.setDirection(Robot.DOWN);
			}
			else if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.UP);
			}
			else if (percent <= (1 / numPoints) * 3)
			{
				context.setDirection(Robot.UP);
			}
		}
		
		protected override function pathInit():void
		{
			// Origin
			path.addPoint(context.x, context.y);
			// Down
			path.addPoint(context.x, context.y + 18 * TILE_SIZE);
			// Up
			path.addPoint(context.x, context.y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
	}
}