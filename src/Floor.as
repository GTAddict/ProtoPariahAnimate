package 
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.net.URLRequest;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	public class Floor extends Entity
	{
		private var image:Image;
		private var loaded:Boolean = false;
		
		public function Floor(x:int, y:int, level:String) 
		{
			layer = 10;	// Bottommost layer.
			
			// For now, always initialize top left, it's going to be a full screen texture.
			this.x = 0;
			this.y = 0;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load(new URLRequest("../levels/" + level + "_Floor.png"));

			type = "Floor";
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
