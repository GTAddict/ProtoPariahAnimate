package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	public class AnyKey extends Entity
	{
		[Embed(source = "../assets/Menu screens/credits.png")]	private const CREDITS_IMG:Class;
		
		// Terrible, terrible, TERRIBLE hack, but no time to implement new system
		private var shouldInvokeCredits:Boolean = false;
		private var creditsPattern:RegExp = /Credits/;
		private var creditsImg:Image;
		
		// Press any key to continue
		// NO, Now it's only the ENTER key.
		public function AnyKey(detail:Array)
		{
			if (creditsPattern.exec(detail[0]))
			{
				shouldInvokeCredits = true;
				creditsImg = new Image(CREDITS_IMG);
			}
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.ANY))
			{
				if (shouldInvokeCredits)
				{
					shouldInvokeCredits = false;
					graphic = creditsImg;
					layer = -100;
				}
				else
				{
					(FP.world as Level).SetStatus(Level.STATUS_SUCCEEDED);	
				}
			}
		}
		
	}

}