package 
{
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 * @author Dale Diaz
	 */
	import PatrolStates.ShortHorizontalPatrol;
	import flash.net.URLRequest;
	import net.flashpunk.World;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.events.IOErrorEvent;
	
	public class Level extends World
	{
		private const levelDataPath:String 	= "../levels/";
		private const levelDataExt:String  	= ".txt";
		
		private var isLoaded:Boolean = false;
		private var playerRef:Player;
		
		public static const STATUS_RUNNING:int 		= 0;
		public static const STATUS_FAILED:int		= 1;
		public static const STATUS_SUCCEEDED:int	= 2;
		
		private var currentStatus:int;
		private var wall:Wall;			// To pass to player controller
		
		public function Level(level:String)
		{
			currentStatus = STATUS_RUNNING;
			
			var floor:Floor = new Floor(0, 0, level);
			add(floor);
			
			wall = new Wall(0, 0, level);
			add(wall);
			
			trace("Creating new level...");
			var fileNameWithPath:String = levelDataPath + level.toString() + levelDataExt;
			LoadLevel(fileNameWithPath);
		}
		
		public function Destroy():void
		{
			removeAll();
		}
		
		private function LoadLevel(levelString:String):void
		{
			var levelFile:URLLoader = new URLLoader();
			levelFile.addEventListener(Event.COMPLETE, OnLoadComplete);
			levelFile.addEventListener(IOErrorEvent.IO_ERROR, OnError);
			
			levelFile.load(new URLRequest(levelString));	
		}
		
		private function OnLoadComplete(e:Event):void
		{
			var objectArray:Array = e.target.data.split(/\n/);
			var keyCardTarget:int = 0;
			
			var playerPattern:RegExp 	= 	/Player/;
			var robotPattern:RegExp 	= 	/Robot/;
			var cameraBotPattern:RegExp	=	/CameraBot/;
			var wallPattern:RegExp 		= 	/Wall/;
			var keyCardPattern:RegExp 	=	/Keycard/;
			var doorPattern:RegExp 		= 	/Door/;
			var floorTilePattern:RegExp	=	/FloorTile/;
			var enterTextPattern:RegExp = 	/EnterText/;
			var terminalPattern:RegExp	=	/Terminal/;
			var closetPattern:RegExp	=  	/Closet/;
			var anyKeyPattern:RegExp	= 	/AnyKey/;
			
			for (var objectName:String in objectArray)
			{
				var object:Array = objectArray[objectName].split(",");
				
				var robots:Array = new Array();
				
				if (robotPattern.exec(object[0]))	
				{
					var robot:Robot = new Robot(object);
					add(robot);
					robots.push(robot);
				}
				else if (cameraBotPattern.exec(object[0]))
				{
					var cameraBot:CameraBot = new CameraBot(object);
					add(cameraBot);
					// Don't add this to the robots array as we're not going to control it anyway.
				}
				else if (doorPattern.exec(object[0]))
				{
					var door:Door = new Door(object);
					add(door);
				}
				else if (keyCardPattern.exec(object[0]))
				{
					++keyCardTarget;
					var keycard:Keycard = new Keycard(object);
					add(keycard);
				}
				else if (terminalPattern.exec(object[0]))
				{
					var terminalRef:Terminal = new Terminal(object);
					add(terminalRef);
				}
				else if (playerPattern.exec(object[0]))
				{
					playerRef = new Player(object, wall);
					add(playerRef);
				}
				else if (closetPattern.exec(object[0]))
				{
					var closet:Closet = new Closet(object);
					add(closet);
				}
				else if (anyKeyPattern.exec(object[0]))
				{
					var anyKey:AnyKey = new AnyKey(object);
					add(anyKey);
				}
			}
			
			if (playerRef)
			{
				playerRef.SetKeysToCollect(keyCardTarget);
			}
			
			isLoaded = true;
			trace("Finished loading");
		}
		
		private function OnError(event:IOErrorEvent):void
		{
			// Possibly skip to the next level if loading fails?
			currentStatus = STATUS_SUCCEEDED;
		}
		
		override public function update():void
		{
			super.update();
			
			if (isLoaded && playerRef)
			{
				if (!playerRef.IsAlive())
				{
					currentStatus = STATUS_FAILED;
				}
				else if (playerRef.HasCompletedObjective())
				{
					currentStatus = STATUS_SUCCEEDED;
				}
			}
		}
		
		public function GetStatus():int
		{
			return currentStatus;
		}
		
		public function SetStatus(status:int):void
		{
			currentStatus = status;
		}
		
	}

}