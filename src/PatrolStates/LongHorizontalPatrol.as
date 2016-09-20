package PatrolStates
{
	/**
	 * @author Dale Diaz
	 */
	
	public class LongHorizontalPatrol extends PatrolState
	{
		private var numPoints:int = 2;
		 
		public function LongHorizontalPatrol(context:Robot):void
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= (1 / numPoints) * 1)
			{
				context.setDirection(Robot.RIGHT);
			}
			else if (percent <= (1 / numPoints) * 2)
			{
				context.setDirection(Robot.LEFT);
			}
			else if (percent <= (1 / numPoints) * 3)
			{
				context.setDirection(Robot.LEFT);
			}
		}
		
		protected override function pathInit():void
		{
			// Origin
			path.addPoint(context.x, context.y);
			// right
			path.addPoint(context.x + 36 * TILE_SIZE, context.y);
			// left
			path.addPoint(context.x, context.y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
	}
}