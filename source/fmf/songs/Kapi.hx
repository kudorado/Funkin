package fmf.songs;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import MenuCharacter.CharacterSetting;
import fmf.characters.*;

class Kapi extends SongPlayer
{

    override function getDadTex()
	{
		var tex = Paths.getSparrowAtlas('kapi/kapi_assets', 'mods');
		dad.frames = tex;
	}


	override function loadMap()
	{
		var daBG = PlayState.CURRENT_SONG == 'wocky' ? "stageback" : 'sunset';


		var bg:FlxSprite = new FlxSprite(-500, -200).loadGraphic(Paths.image('kapi/' + daBG, 'mods'));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;
		playState.add(bg);

		var stageFront:FlxSprite = new FlxSprite(-400, 550).loadGraphic(Paths.image('kapi/stagefront', 'mods'));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1));
		stageFront.updateHitbox();
		stageFront.antialiasing = true;
		stageFront.scrollFactor.set(0.9, 0.9);
		playState.add(stageFront);
		
	}

	override function createDadAnimations():Void
	{
		var animation = dad.animation;
		animation.addByPrefix('idle', 'Dad idle dance', 24);
		animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
		animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
		animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
		animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);
		dad.animation = animation;
	}

	override function createDadAnimationOffsets():Void
	{

		dad.addOffset('idle');
		dad.addOffset("singUP", 1, -8);
		dad.addOffset("singRIGHT", 0, -45);
		dad.addOffset("singLEFT", 0, 30);
		dad.addOffset("singDOWN", 0, -110);

		dad.dance();

	}

	override function getGFTex():Void
	{
		var tex = Paths.getSparrowAtlas('kapi/GF_assets', 'mods');
		gf.frames = tex;

	}

	override function createGFAnimations()
	{
		var animation = gf.animation;
		animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
	
		gf.animation = animation;
	}

	override function createGFAnimationOffsets()
	{

		gf.addOffset('danceLeft', 0, -9);
		gf.addOffset('danceRight', 0, -9);

		gf.scale.x = 0.65;
		gf.scale.y = 0.65;

		gf.y -= 25;	
		gf.x += 75;	

	}

	override function createDad()
	{
        dad = new Dad(0, 125);
		getDadTex();
		createDadAnimations();
		createDadAnimationOffsets();
		dad.dance();

    }

	public override function createCharacters()
	{
		super.createCharacters();

		dad.x += 200;
		dad.y += 250;

		dad.scale.x = 0.75;
		dad.scale.y = 0.75;

		gf.y -= 25;

		bf.x += 100;
		bf.y += 50;

		bf.scale.x *= 0.75;
		bf.scale.y *= 0.75;

	}

	public override function getDadIcon(icon:HealthIcon)
	{
		icon.loadGraphic(Paths.image('kapi/iconGrid', 'mods'), true, 150, 150);
		icon.animation.add('dad', [12, 13], 0, false, false);
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