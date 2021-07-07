package fmf.songs;

import flixel.FlxSprite;
import MenuCharacter.CharacterSetting;
import fmf.characters.*;

class Whitty extends SongPlayer
{

    override function getDadTex()
	{
		var tex = Paths.getSparrowAtlas('whitty/WhittySprites', 'mods');
		dad.frames = tex;
	}


	override function loadMap()
	{
		var bg:FlxSprite = new FlxSprite(-48, -448).loadGraphic(Paths.image('whitty/whittyBack', 'mods'));
		bg.antialiasing = true;
		// bg.active = false;
		bg.scale.x = 1.3;
		bg.scale.y = 1.3;
		bg.scrollFactor.set(0.9, 0.9);
		playState.add(bg);

		var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('whitty/whittyFront', "mods"));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		stageFront.antialiasing = true;
		stageFront.scrollFactor.set(0.9, 0.9);
		stageFront.active = false;
		playState.add(stageFront);

	}

	override function createDadAnimations():Void
	{
		var animation = dad.animation;
		animation.addByPrefix('idle', 'Idle', 24, false);
		animation.addByPrefix('singUP', 'Sing Up', 24, false);
		animation.addByPrefix('singRIGHT', 'Sing Right', 24, false);
		animation.addByPrefix('singLEFT', 'Sing Left', 24, false);
		animation.addByPrefix('singDOWN', 'Sing Down', 24, false);
		dad.animation = animation;
	}

	override function createDadAnimationOffsets():Void
	{
		dad.addOffset('idle', -63, 1);
		dad.addOffset('singUP', 13, 48);
		dad.addOffset('singRIGHT', -81, 37);
		dad.addOffset('singLEFT', -46, -20);
		dad.addOffset('singDOWN', -80, -40);

		dad.dance();

	}

	override function getGFTex():Void
	{
		var tex = Paths.getSparrowAtlas('week_whitty/GF_Standing_Sway');
		gf.frames = tex;

	}

	override function createGFAnimations()
	{
		var animation = gf.animation;
		animation.addByPrefix('sad', 'Sad', 24, false);
		animation.addByPrefix('danceLeft', 'Idle Left', 24, false);
		animation.addByPrefix('danceRight', 'Idle Right', 24, false);
		animation.addByPrefix('scared', 'Scared', 24, false);
		gf.animation = animation;
	}

	override function createGFAnimationOffsets()
	{
  
		gf.addOffset('sad', -140, -153);
		gf.addOffset('danceLeft', -140, -153);
		gf.addOffset('danceRight', -140, -153);
		gf.addOffset('scared', -140, -110);

		gf.playAnim('danceRight');
		gf.dance();

		gf.x -= 150;
		gf.y -= 100;

	}

	override function createDad()
	{
        dad = new Dad(0, 125);
		getDadTex();
		createDadAnimations();
		createDadAnimationOffsets();
		dad.dance();

    }

	public override function getDadIcon(icon:HealthIcon)
	{
		icon.loadGraphic(Paths.image('iconGrid'), true, 150, 150);
		icon.animation.add('dad', [17, 18], 0, false, false);
		icon.animation.play("dad");
	}

	public override function setDadMenuCharacter(dad:MenuCharacter)
	{
		super.setDadMenuCharacter(dad);

		var frames = Paths.getSparrowAtlas('whitty/whitty', 'mods');
		dad.frames = frames;

		dad.animation.addByPrefix('dad', "Whitty idle dance BLACK LINE", 24);
		dad.animation.play('dad');
		setMenuCharacter(dad, new CharacterSetting(-200, 25, 1));
	}
}