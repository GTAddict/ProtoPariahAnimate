package PatrolStates
{
	/**
	 * @author Dale Diaz
	 */
	
	public class ShortHorizontalPatrol extends PatrolState
	{
		private var numPoints:int = 7;
		
		public function ShortHorizontalPatrol(context:Robot)
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= (1 / numPoints) * 3)
			{
				context.setDirection(Robot.RIGHT);
			}
			else
			{
				context.setDirection(Robot.LEFT);
			}
		}
		
		protected override function pathInit():void
		{
			// Origin
			path.addPoint(context.x, context.y);
			// Right
			path.addPoint(context.x + 3 * TILE_SIZE, context.y);
			// Left
			path.addPoint(context.x, context.y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}
}