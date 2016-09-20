package
{
	import flash.events.IOErrorEvent;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Krishna Bharadwaj Y
	 */
	
	public class Main extends Engine 
	{
		private const SCREEN_WIDTH:Number = 1920;
		private const SCREEN_HEIGHT:Number = 1080;
		private const FRAME_RATE:Number = 60;
		private const FIXED_FRAME:Boolean = false;
		
		private var MAX_STAGES:int = 14;
		
		private var currentStageNo:Number = 1;
		private var currentStageRef:Level;
		
		private const LEVEL_FAIL:String	= "Fail";
		private const levelFail:Level = new Level(LEVEL_FAIL);
		
		private const LEVEL_INTRO:String = "Intro";
		private const levelIntro:Level = new Level(LEVEL_INTRO);
		
		private const LEVEL_VICTORY:String = "Victory";
 		private const levelVictory:Level = new Level(LEVEL_VICTORY);
		
		private var soundEntity:SoundEntity;
			
		public function Main() 
		{
			super(SCREEN_WIDTH, SCREEN_HEIGHT, FRAME_RATE, FIXED_FRAME);
			LoadConfig();
			soundEntity = new SoundEntity();
		}
		
		override public function init():void
		{
			trace("Successful start.");
			FP.world = currentStageRef = levelIntro;
		}
		
		private function LoadConfig():void
		{	
			var levelFile:URLLoader = new URLLoader();
			levelFile.addEventListener(Event.COMPLETE, OnLoadConfigComplete);
			levelFile.addEventListener(IOErrorEvent.IO_ERROR, OnLoadConfigFail);
			
			levelFile.load(new URLRequest("game.config"));	
			
		}
		
		private function OnLoadConfigComplete(e:Event):void
		{
			const currentLevelPattern:RegExp 	= /currentLevel/;
			const maxLevelsPattern:RegExp		= /maxLevels/;
			const fullScreenPattern:RegExp		= /fullScreen/;
			
			var objectArray:Array = e.target.data.split(/\n/);
			
			for (var objectName:String in objectArray)
			{
				var object:Array = objectArray[objectName].split("=");
				
				if (currentLevelPattern.exec(object[0]))
				{
					currentStageNo = object[1];
				}
				else if (maxLevelsPattern.exec(object[0]))
				{
					MAX_STAGES = object[1];
				}
				else if (fullScreenPattern.exec(object[0]))
				{	
					FP.stage.displayState = "fullScreen";
				}
			}
		}
		
		private function OnLoadConfigFail(event:IOErrorEvent):void
		{
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (currentStageRef)
			{
				switch (currentStageRef.GetStatus())
				{
					case Level.STATUS_RUNNING:		// If it's all good, just exit
						return;
					
					case Level.STATUS_SUCCEEDED:
						if (currentStageRef != levelFail && currentStageRef != levelVictory && currentStageRef != levelIntro)
						{
							currentStageNo++;
							trace("Destroying world");
							currentStageRef.Destroy();
							FP.world = currentStageRef = null;
							
						}
						else if (currentStageRef == levelVictory)
						{
							FP.world = currentStageRef = levelIntro;
							levelIntro.SetStatus(Level.STATUS_RUNNING);
							currentStageNo = 1;
						}
						else
						{
							FP.world = currentStageRef = null;
						}
						break;
						
					case Level.STATUS_FAILED:
						trace("Destroying world");
						currentStageRef.Destroy();
						FP.world = currentStageRef = null;
						FP.world = currentStageRef = levelFail;
						soundEntity.onFail();
						levelFail.SetStatus(Level.STATUS_RUNNING);
						return;
				}
			}
			else
			{
				trace("Creating new world...");
				if (currentStageNo > MAX_STAGES)
				{
					FP.world = currentStageRef = levelVictory;
					levelVictory.SetStatus(Level.STATUS_RUNNING);
				}
				else
				{
					FP.world = currentStageRef = new Level(currentStageNo.toString());	
					soundEntity.onFailOver();
				}
			}
		}
		
	}
	
}