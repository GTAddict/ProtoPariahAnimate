package 
{
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	public class Door extends Entity
	{
		[Embed(source = "../assets/Entrance_start.png")]	private const ENTRANCE_IMG:Class;
		[Embed(source = "../assets/Exit_up.png")]			private const EXIT_IMG_UP:Class;
		[Embed(source = "../assets/Exit_down.png")]			private const EXIT_IMG_DOWN:Class;
		[Embed(source = "../assets/Exit_left.png")]			private const EXIT_IMG_LEFT:Class;
		[Embed(source = "../assets/Exit_right.png")]		private const EXIT_IMG_RIGHT:Class;

		private const entrancePattern:RegExp 	= /Entrance/;
		private const exitPattern:RegExp		= /Exit/;
		
		private const upPattern:RegExp			= /Up/;
		private const downPattern:RegExp		= /Down/;
		private const leftPattern:RegExp		= /Left/;
		private const rightPattern:RegExp		= /Right/;
		
		public function Door(detail:Array) 
		{
			this.x = detail[1];
			this.y = detail[2];
			
			// If entrance specified, load it, else
			// default to exit
			if (entrancePattern.exec(detail[0]))
			{
				graphic = new Image(ENTRANCE_IMG);
				type = "EntranceDoor";
			}
			else
			{
				if (downPattern.exec(detail[0]))
				{
					graphic = new Image(EXIT_IMG_DOWN);
				}
				else if (leftPattern.exec(detail[0]))
				{
					graphic = new Image(EXIT_IMG_LEFT);
				}
				else if (rightPattern.exec(detail[0]))
				{
					graphic = new Image(EXIT_IMG_RIGHT);
				}
				else
				{
					graphic = new Image(EXIT_IMG_UP);
				}
				
				type = "ExitDoor";
			}
			
			setHitbox((graphic as Image).scaledWidth, (graphic as Image).scaledHeight);
		}
		
	}

}