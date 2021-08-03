package fmf.songs;

import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;
import MenuCharacter.CharacterSetting;
import fmf.characters.*;

class TabiMad extends Tabi
{

	var genocideBG:FlxSprite;
	var genocideBoard:FlxSprite;
	var siniFireBehind:FlxTypedGroup<SiniFire>;
	var siniFireFront:FlxTypedGroup<SiniFire>;

	var trail:FlxTrail;

	override function getDadTex()
	{
		var tex = Paths.getSparrowAtlas('tabi/mad/MadTabi', 'mods');
		dad.frames = tex;
	}

	override function createFrontObject()
	{
		var sumsticks:FlxSprite = new FlxSprite(-600, -325).loadGraphic(Paths.image('tabi/mad/overlayingsticks', 'mods'));
		sumsticks.antialiasing = true;
		sumsticks.scrollFactor.set(0.95, 0.95);
		playState.add(sumsticks);
	}

	override function getGFTex()
	{
		var tex = Paths.getSparrowAtlas('tabi/mad/PostExpGF_Assets', 'mods');
		gf.frames = tex;
	}

	override function createGFAnimations()
	{
		gf.animation.addByIndices('danceLeft', 'GF LayedDownHurt ', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
		gf.animation.addByPrefix('danceRight', 'GF LayedDownHurt ',  24, true);
	}

	override function createGFAnimationOffsets()
	{
		gf.addOffset('danceLeft', -300, -250);
		gf.addOffset('danceRight', -300, -250);

		gf.playAnim('danceRight');

	}

	override function loadMap()
	{
	
		playState.defaultCamZoom = 0.8;

		siniFireBehind = new FlxTypedGroup<SiniFire>();
		siniFireFront = new FlxTypedGroup<SiniFire>();

		genocideBG = new FlxSprite(-900, -300).loadGraphic(Paths.image('tabi/fire/wadsaaa', 'mods'));
		genocideBG.antialiasing = true;
		genocideBG.scrollFactor.set(0.95, 0.95);
		playState.add(genocideBG);


		for (i in 0...2)
		{
			var daFire:SiniFire = new SiniFire(genocideBG.x + (720 + (((95 * 10) / 2) * i)), genocideBG.y + 180, true, false, 30, i * 10, 84);
			daFire.antialiasing = true;
			daFire.scrollFactor.set(0.95, 0.95);
			daFire.scale.set(0.4, 1);
			daFire.y += 50;
			siniFireBehind.add(daFire);
		}

		playState.add(siniFireBehind);

		// genocide board is already in genocidebg but u know shit layering for fire lol
		genocideBoard = new FlxSprite(genocideBG.x, genocideBG.y).loadGraphic(Paths.image('tabi/fire/boards', 'mods'));
		genocideBoard.antialiasing = true;
		genocideBoard.scrollFactor.set(0.95, 0.95);
		playState.add(genocideBoard);

		// front fire shit

		var fire1:SiniFire = new SiniFire(genocideBG.x + (-100), genocideBG.y + 889, true, false, 30);
		fire1.antialiasing = true;
		fire1.scrollFactor.set(0.95, 0.95);
		fire1.scale.set(2.5, 1.5);
		fire1.y -= fire1.height * 1.5;
		fire1.flipX = true;

		var fire2:SiniFire = new SiniFire((fire1.x + fire1.width) - 80, genocideBG.y + 889, true, false, 30);
		fire2.antialiasing = true;
		fire2.scrollFactor.set(0.95, 0.95);
		// fire2.scale.set(2.5, 1);
		fire2.y -= fire2.height * 1;

		var fire3:SiniFire = new SiniFire((fire2.x + fire2.width) - 30, genocideBG.y + 889, true, false, 30);
		fire3.antialiasing = true;
		fire3.scrollFactor.set(0.95, 0.95);
		// fire3.scale.set(2.5, 1);
		fire3.y -= fire3.height * 1;

		var fire4:SiniFire = new SiniFire((fire3.x + fire3.width) - 10, genocideBG.y + 889, true, false, 30);
		fire4.antialiasing = true;
		fire4.scrollFactor.set(0.95, 0.95);
		fire4.scale.set(1.5, 1.5);
		fire4.y -= fire4.height * 1.5;

		siniFireFront.add(fire1);
		siniFireFront.add(fire2);
		siniFireFront.add(fire3);
		siniFireFront.add(fire4);

		playState.add(siniFireFront);

		// more layering shit
		var fuckYouFurniture:FlxSprite = new FlxSprite(genocideBG.x, genocideBG.y).loadGraphic(Paths.image('tabi/fire/glowyfurniture', 'mods'));
		fuckYouFurniture.antialiasing = true;
		fuckYouFurniture.scrollFactor.set(0.95, 0.95);
		playState.add(fuckYouFurniture);

		#if !mobile
		PlayState.songOffset = -650;
		#end
		
		#if mobile
		PlayState.songOffset = -300;
		#end


	}

	override function createDadAnimations():Void
	{
		var animation = dad.animation;
		animation.addByPrefix('idle', 'MadTabiIdle', 24, false);
		animation.addByPrefix('singUP', 'MadTabiUp', 24, false);
		animation.addByPrefix('singDOWN', 'MadTabiDown', 24, false);
		animation.addByPrefix('singLEFT', 'MadTabiLeft', 24, false);
		animation.addByPrefix('singRIGHT', 'MadTabiRight', 24, false);
		dad.animation = animation;
	}

	override function createDadAnimationOffsets():Void
	{
		dad.addOffset('idle', 2, -14);

		dad.addOffset("singUP", 32, -19);
		dad.addOffset("singRIGHT", -4, -13);
		dad.addOffset("singLEFT", 60, -19);
		dad.addOffset("singDOWN", -30, -25);

		dad.dance();

	}

	public override function createCharacters()
	{
		super.createCharacters();

		bf.x -= 575;
		bf.y -= 50;

		dad.x -= 650;
		dad.y -= 50;

		dad.scrollFactor.set(0.95, 0.95);
		bf.scrollFactor.set(0.95, 0.95);

		if (FlxG.save.data.distractions)
		{
			trail = new FlxTrail(dad, null, 1, 12, 0.85, 0.069);
			trail.color = FlxColor.RED;
			
			trail.scale.x = 5;
			trail.scale.y = 5;

			playState.add(trail);
			trail.visible = false;
		}

		createFrontObject();

	}

	override function dadNoteEvent(curBeat:Int, noteData:Note)
	{
		if (curBeat % 6 == 0)
		{
			playState.defaultCamZoom = 1.25;
			playState.shakeGenocide();

			if (FlxG.save.data.distractions)
			{
				trail.visible = true;
			}

		}
		else
		{
			playState.defaultCamZoom = 0.95;
			playState.shakePrettyBig();

			if (FlxG.save.data.distractions)
				trail.visible = false;

		}
	}

	override function updateCamFollowDad()
	{
		playState.camFollow.y = dad.getMidpoint().y + 100;
	}

	override function bfNoteEvent(curBeat:Int, noteData:Note)
	{

		playState.defaultCamZoom = 0.8;
		playState.shakeMinimal();
	}

	public override function getDadIcon(icon:HealthIcon)
	{
		icon.loadGraphic(Paths.image('iconGrid'), true, 150, 150);
		icon.animation.add('dad', [14, 15], 0, false, false);
		icon.animation.play("dad");
	}

}