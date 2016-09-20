package 
{
	/**
	 * ...
	 * @author Dale Diaz
	 */
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	
	public class SoundEntity extends Entity
	{
		[Embed(source = "../Sound/IntroFinal.mp3")] 		private const INTRO_SOUND:Class;
		[Embed(source = "../Sound/LoopFinal.mp3")]			private const LOOP_SOUND:Class;
		[Embed(source = "../Sound/IntroFinalFlanged.mp3")] 	private const INTRO_SOUND_FLANGE:Class;
		[Embed(source = "../Sound/LoopFinalFlanged.mp3")]	private const LOOP_SOUND_FLANGE:Class;
		
		[Embed(source = "../sound/Collect.mp3")]			private const COLLECT_SOUND:Class;
		[Embed(source = "../sound/Death.mp3")]				private const DEATH_SOUND:Class;
		[Embed(source = "../sound/On.mp3")]					private const ON_SOUND:Class;
		[Embed(source = "../sound/RobotOnOff.mp3")]			private const ROBOT_ON_OFF:Class;
		
		
		private var loopSound:Sfx;
		private var introSound:Sfx;
		private var loopSoundFlange:Sfx;
		private var introSoundFlange:Sfx;
		
		public static var deathSound:Sfx;
		public static var offSwitchSound:Sfx;
		public static var robotOnSound:Sfx;
		public static var collectSound:Sfx;
		
		private var soundEnabled:Boolean = true;
		
		public function SoundEntity() 
		{
			if (!soundEnabled)	return;
			
			introSound = new Sfx(INTRO_SOUND, introComplete);
			loopSound = new Sfx(LOOP_SOUND);
			
			introSoundFlange = new Sfx(INTRO_SOUND_FLANGE);
			loopSoundFlange = new Sfx(LOOP_SOUND_FLANGE);
			
			deathSound = new Sfx(DEATH_SOUND);
			offSwitchSound = new Sfx(ON_SOUND);
			robotOnSound = new Sfx(ROBOT_ON_OFF);
			collectSound = new Sfx(COLLECT_SOUND);
			
			introSound.play();
			introSoundFlange.play();
			
			onFailOver();
			
			name = "SoundEntity";
		}
		
		public static function playSound(string:String):void
		{
			if (string == "DEATH")
			{
				SoundEntity.deathSound.play();
			}
			else if (string == "OFF")
			{
				SoundEntity.offSwitchSound.play();
				SoundEntity.robotOnSound.play();
			}
			else if (string == "ROBOTON")
			{
				SoundEntity.robotOnSound.play();
			}
			else if (string == "COLLECT")
			{
				SoundEntity.collectSound.play();
			}
		}
		
		private function introComplete():void
		{
			loopSound.loop();
			loopSoundFlange.loop();
			onFailOver();
		}
		
		public function onFail():void
		{
			introSoundFlange.volume = 1;
			introSound.volume = 0;
			loopSoundFlange.volume = 1;
			loopSound.volume = 0;
		}
		
		public function onFailOver():void
		{
			introSoundFlange.volume = 0;
			introSound.volume = 1;
			loopSoundFlange.volume = 0;
			loopSound.volume = 1;
		}
		
	}

}