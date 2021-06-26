package fmf.songs;

import fmf.songs.*;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import fmf.characters.*;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import Song.SwagSong;

// base class execute song data
class SongPlayer extends  BaseSong
{
	// characters shit
	public var playState:PlayState;
	public var gf:Character;
	public var dad:Character;

	// dialogue
	public var dialogue:Array<String>;
	public var dialogueBox:DialogueBox;

	// camera position at start
	public var camPos:FlxPoint;

	// start countdown
	var readySprite:FlxSprite;
	var setSprite:FlxSprite;
	var goSprite:FlxSprite;
	var introAlts:Array<String> = ['ready', "set", "go"];
	
		
	// virtual function

	//empty init
	public function new(){}
	// update function
	public function update(elapsed:Float):Void {}
	// mid song event update
	public function midSongEventUpdate(curBeat:Int):Void{} 
	// for setting camOffset at start
	// public function setCamPosition():Void{}
	// update camera follow dad depending on song
	public function updateCamFollowDad():Void{}
	// update camera follow bf depending on song
	public function updateCamFollowBF():Void{} 


	//initalize function
	public function init(playState:PlayState):Void
	{
		this.playState = playState;

		loadMap();
		createCharacters();
		initVariables();
	}

	function initVariables()
	{
		camPos = new FlxPoint(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y);
		// setCamPosition();
	}


	// what map should we load
	function loadMap():Void
	{
		playState.defaultCamZoom = 0.9;
		var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;
		playState.add(bg);

		var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		stageFront.antialiasing = true;
		stageFront.scrollFactor.set(0.9, 0.9);
		stageFront.active = false;
		playState.add(stageFront);

		var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		stageCurtains.antialiasing = true;
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.active = false;

		playState.add(stageCurtains);
	}

	// camera follow initalize
	public function applyCamPosition():Void
	{
		playState.camFollow = new FlxObject(0, 0, 1, 1);
		playState.camFollow.setPosition(camPos.x, camPos.y);
	}


	// dialogue handle
	public function createDialogue(callback:Void->Void):Void
	{
		var path = PlayState.CURRENT_SONG + '/' + PlayState.CURRENT_SONG + '-dialogue';
		dialogue = CoolUtil.coolTextFile(Paths.txt(PlayState.playingSong.folder +  path));
		dialogueBox = new DialogueBox(false, dialogue);
		dialogueBox.scrollFactor.set();
		dialogueBox.finishThing = callback;
		dialogueBox.cameras = [playState.camHUD];
		trace("Create dialogue at path: " + path);
	}

	public function showDialogue():Void
	{
		playState.add(dialogueBox);
		trace('whee mai dialgue siht!');
	}



	// what character should we create
	function createCharacters():Void
	{
		createGF();
		createBF();
		createDad();

		gf.scrollFactor.set(0.95, 0.95);

		playState.add(gf);
		playState.add(dad);
		playState.add(bf);
	}

	// get GF skin
	private function getGFTex()
	{
		var tex = Paths.getSparrowAtlas('gf/GF_tutorial');
		gf.frames = tex;
		// tex = null;
	}

	// create GF animations
	private function createGFAnimations():Void
	{
		var animation = gf.animation;
		animation.addByPrefix('cheer', 'GF Cheer', 24, false);
		animation.addByPrefix('singLEFT', 'GF left note', 24, false);
		animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
		animation.addByPrefix('singUP', 'GF Up Note', 24, false);
		animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
		animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
		animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
		animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
		animation.addByPrefix('scared', 'GF FEAR', 24);

		gf.animation = animation;

	}

	// create GF animation offsets
	private function createGFAnimationOffsets():Void
	{
		gf.addOffset('cheer');
		gf.addOffset('sad', -2, -2);
		gf.addOffset('danceLeft', 0, -9);
		gf.addOffset('danceRight', 0, -9);

		gf.addOffset("singUP", 0, 4);
		gf.addOffset("singRIGHT", 0, -20);
		gf.addOffset("singLEFT", 0, -19);
		gf.addOffset("singDOWN", 0, -20);
		gf.addOffset('hairBlow', 45, -8);
		gf.addOffset('hairFall', 0, -9);

		gf.addOffset('scared', -2, -17);

		gf.playAnim('danceRight');
		gf.dance();
	}

	// get GF version
	function getGfVersion():Character
	{
		return new GF(400, 250);
	}

	// create GF
	public function createGF()
	{
		gf = getGfVersion();
		getGFTex();
		createGFAnimations();
		createGFAnimationOffsets();
	}

	// get dad skin
	private function getDadTex()
	{
		var tex = Paths.getSparrowAtlas('gf/GF_tutorial');
		dad.frames = tex;
	}

	// create dad animation
	private function createDadAnimations()
	{
		var animation = dad.animation;
		animation.addByPrefix('cheer', 'GF Cheer', 24, false);
		animation.addByPrefix('singLEFT', 'GF left note', 24, false);
		animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
		animation.addByPrefix('singUP', 'GF Up Note', 24, false);
		animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
		animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
		animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
		animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
		animation.addByPrefix('scared', 'GF FEAR', 24);
		dad.animation = animation;

	}

	// create dad animation offsets
	private function createDadAnimationOffsets()
	{
		dad.addOffset('cheer');
		dad.addOffset('sad', -2, -2);
		dad.addOffset('danceLeft', 0, -9);
		dad.addOffset('danceRight', 0, -9);

		dad.addOffset("singUP", 0, 4);
		dad.addOffset("singRIGHT", 0, -20);
		dad.addOffset("singLEFT", 0, -19);
		dad.addOffset("singDOWN", 0, -20);
		dad.addOffset('hairBlow', 45, -8);
		dad.addOffset('hairFall', 0, -9);

		dad.addOffset('scared', -2, -17);

		dad.playAnim('danceRight');
		dad.dance();
	}

	// get dad version
	function getDadVersion():Character
	{
		return new Character(100, 100);
	}

	// create dad
	public function createDad()
	{
		dad = getDadVersion();
		getDadTex();
		createDadAnimations();
		createDadAnimationOffsets();

		dad.x = gf.x;
		dad.y = gf.y;
	}

	//UI Function

	// start countdown
	// show ready, set, go image and sound
	public function startCountdown():Void
	{
		playState.talking = false;
		playState.startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;
		playState.startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();
			bf.playAnim('idle');
			switch (swagCounter)
			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3' + introType()), 0.6);
				case 1:
					ready();
				case 2:
					set();
				case 3:
					go();
				case 4:
			}

			swagCounter += 1;
		}, 5);
	}

	// get alt suffix for countdown sound
	// current we have default and school suffix
	private function introType():String { return ""; }

	// countdown ready
	private function ready()
	{
		readySprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
		readySprite.scrollFactor.set();
		readySprite.updateHitbox();
		readySprite.screenCenter();
		playState.add(readySprite);
		FlxTween.tween(readySprite, {y: readySprite.y += 100, alpha: 0}, Conductor.crochet / 1000, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				readySprite.destroy();
			}
		});
		FlxG.sound.play(Paths.sound('intro2' + introType()), 0.6);
	}

	// countdown set
	private function set()
	{
		setSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
		setSprite.scrollFactor.set();
		setSprite.screenCenter();
		playState.add(setSprite);
		FlxTween.tween(setSprite, {y: setSprite.y += 100, alpha: 0}, Conductor.crochet / 1000, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				setSprite.destroy();
			}
		});
		FlxG.sound.play(Paths.sound('intro1' + introType()), 0.6);
	}
	
	// countdown go
	private function go()
	{
		goSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
		goSprite.scrollFactor.set();
		goSprite.updateHitbox();
		goSprite.screenCenter();
		playState.add(goSprite);


		FlxTween.tween(goSprite, {y: goSprite.y += 100, alpha: 0}, Conductor.crochet / 1000, {
			ease: FlxEase.cubeInOut,
			onComplete: function(twn:FlxTween)
			{
				goSprite.destroy();
			}
		});

		FlxG.sound.play(Paths.sound('introGo' + introType()), 0.6);
		playState.isGameStarted = true;

	}


}