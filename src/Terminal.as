package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Dale Diaz
	 */
	public class Terminal extends Entity 
	{
		[Embed(source = "../assets/Console_down.png")]			private const TERMINAL_DOWN:Class;
		[Embed(source = "../assets/Console_left.png")]			private const TERMINAL_LEFT:Class;
		[Embed(source = "../assets/Console_right.png")]			private const TERMINAL_RIGHT:Class;
		[Embed(source = "../assets/Console_up.png")]			private const TERMINAL_UP:Class;
		
		[Embed(source = "../assets/Console_lock_up.png")]		private const TERMINAL_UP_LOCK:Class;
		[Embed(source = "../assets/Console_lock_down.png")]		private const TERMINAL_DOWN_LOCK:Class;
		[Embed(source = "../assets/Console_lock_left.png")]		private const TERMINAL_LEFT_LOCK:Class;
		[Embed(source = "../assets/Console_lock_right.png")]	private const TERMINAL_RIGHT_LOCK:Class;
		
		
		private var isActive:Boolean;
		private var activeImg:Image;
		private var inactiveImg:Image;
	
		private const upPattern:RegExp 		= /Up/;
		private const downPattern:RegExp 	= /Down/;
		private const leftPattern:RegExp 	= /Left/;
		private const rightPattern:RegExp 	= /Right/;
		
		public function Terminal(detail:Array) 
		{
			super(detail[1], detail[2]);
			isActive = true;
			
			if (leftPattern.exec(detail[0]))
			{
				activeImg 	= new Image(TERMINAL_LEFT);
				inactiveImg = new Image(TERMINAL_LEFT_LOCK);
			}
			else if (rightPattern.exec(detail[0]))
			{
				activeImg 	= new Image(TERMINAL_RIGHT);
				inactiveImg = new Image(TERMINAL_RIGHT_LOCK);
			}
			else if (downPattern.exec(detail[0]))
			{
				activeImg 	= new Image(TERMINAL_DOWN);
				inactiveImg = new Image(TERMINAL_DOWN_LOCK);
			}
			else 
			{
				activeImg 	= new Image(TERMINAL_UP);
				inactiveImg = new Image(TERMINAL_UP_LOCK);
			}
			
			graphic = activeImg;
			setHitbox(activeImg.scaledWidth, activeImg.scaledHeight);
			
			type = "Terminal";
		}
		
		public function activate():void
		{
			isActive = true;
			graphic = activeImg;
		}
		
		public function deactivate():void
		{
			isActive = false;
			graphic = inactiveImg;
		}
		
		public function isAvailable():Boolean
		{
			return isActive;
		}
		
	}

}