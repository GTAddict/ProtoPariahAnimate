package 
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	public class CameraBot extends Robot
	{
		[Embed(source = "../assets/Floatbot_back_up.png")]		private const CAMERABOT_UP_IMG:Class;
		[Embed(source = "../assets/Floatbot_front_down.png")]	private const CAMERABOT_DOWN_IMG:Class;
		[Embed(source = "../assets/Floatbot_left.png")]			private const CAMERABOT_LEFT:Class;
		[Embed(source = "../assets/Floatbot_right.png")]		private const CAMERABOT_RIGHT:Class;
		
		public function CameraBot(detail:Array) 
		{
			super(detail);
		}
		
		override public function setTextures():void
		{
			activeLeftImg 	= new Image(CAMERABOT_LEFT);
			activeRightImg 	= new Image(CAMERABOT_RIGHT);
			activeUpImg 	= new Image(CAMERABOT_UP_IMG);
			activeDownImg 	= new Image(CAMERABOT_DOWN_IMG);
		}
		
		override public function setType():void
		{
			type = "CameraBot";
		}
		
		override public function turnOff():void
		{
			// Do nothing, this robot cannot be turned off
		}
		
		override public function select():void
		{
			// Do nothing, this robot cannot be selected
		}
		
	}

}