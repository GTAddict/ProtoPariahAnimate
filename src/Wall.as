package 
{
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.net.URLRequest;
	import flash.display.BitmapData;
	
	public class Wall extends Entity
	{	
		private var image:Image;
		private var loaded:Boolean = false;
		
		public function Wall(x:int, y:int, level:String) 
		{
			layer = 9;	// Over floor.
			
			// For now, let's initialize to top left.
			this.x = 0;
			this.y = 0;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load(new URLRequest("../levels/" + level + "_Wall.png"));	
			
			type = "Wall";
		}
		
		private function onComplete(event:Event):void
		{
			image = new Image(event.target.content.bitmapData);
			graphic = image;
		}
		
		private function onError(event:IOErrorEvent):void
		{
			// Do nothing
		}
		
		public function isLoaded():Boolean
		{
			return loaded;
		}
		
	}

}