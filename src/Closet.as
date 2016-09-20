package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	public class Closet extends Entity
	{
		[Embed(source = "../assets/Closet_left.png")]	private const CLOSET_IMG_LEFT:Class;
		[Embed(source = "../assets/Closet_right.png")]	private const CLOSET_IMG_RIGHT:Class;
		[Embed(source = "../assets/Closet_up.png")]		private const CLOSET_IMG_UP:Class;
		[Embed(source="../assets/Closet_down.png")]		private const CLOSET_IMG_DOWN:Class;

		
		private var closetImgLeft:Image;
		private var closetImgRight:Image;
		private var closetImgUp:Image;
		private var closetImgDown:Image;
		
		private const upPattern:RegExp 		=  /Up/;
		private const downPattern:RegExp 	=  /Down/;
		private const leftPattern:RegExp 	=  /Left/;
		private const rightPattern:RegExp 	=  /Right/;
		
		private const closetPattern:RegExp = /Closet/;
		
		public function Closet(detail:Array) 
		{
			this.x = detail[1];
			this.y = detail[2];
			
			if (upPattern.exec(detail[0]))
			{
				graphic = closetImgUp = new Image(CLOSET_IMG_UP);
			}
			else if (downPattern.exec(detail[0]))
			{
				graphic = closetImgDown = new Image(CLOSET_IMG_DOWN);
			}
			else if (leftPattern.exec(detail[0]))
			{
				graphic = closetImgLeft = new Image(CLOSET_IMG_LEFT);
			}
			else // default: if (rightPattern.exec(detail[0]))
			{
				graphic = closetImgRight = new Image(CLOSET_IMG_RIGHT);
			}
			
			setHitbox((graphic as Image).scaledWidth, (graphic as Image).scaledHeight);
		}
		
	}

}