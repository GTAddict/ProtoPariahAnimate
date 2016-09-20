package PatrolStates 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class MediumVerticalBotSpawnPatrol extends PatrolState 
	{
		private var numPoints:int = 10;
		
		public function MediumVerticalBotSpawnPatrol(context:Robot) 
		{
			super(context);
		}
		
		public override function update():void
		{
			var percent:Number = Math.floor(path.percent * 100) / 100;
			
			if (percent <= (1 / numPoints) * 5)
			{
				context.setDirection(Robot.UP);
			}
			else 
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
			// Down 5
			path.addPoint(x, y - 5 * TILE_SIZE);
			// Up 5
			path.addPoint(x, y);
		}
		
		protected override function reset():void
		{
			path.start();
		}
		
	}

}