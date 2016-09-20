package 
{
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	import flash.system.ImageDecodingPolicy;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	public class Keycard extends Entity
	{
		[Embed(source = "../assets/Keycard_item.png")]	private const KEYCARD:Class;
		[Embed(source = "../assets/FinalChip.png")]		private const CHIP:Class;
		
		private const chipPattern:RegExp = /Chip/;
		private var isChip:Boolean = false;
		
		public function Keycard(detail:Object) 
		{
			this.x = detail[1];
			this.y = detail[2];
			
			if (chipPattern.exec(detail[0]))
			{
				graphic = new Image(CHIP);
				isChip = true;
			}
			else
			{
				graphic = new Image(KEYCARD);
			}
			
			type = "Keycard";
			
			setHitbox((graphic as Image).scaledWidth, (graphic as Image).scaledHeight);
		}
		
		public function getIsChip():Boolean
		{
			return isChip;
		}
		
	}

}