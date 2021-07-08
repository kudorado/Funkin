package fmf.vfx;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;

class FireEffect extends VFX
{
	// get vfx depending on selection & song
	private function getArray(num:Int):Array<Int>
	{
		var result:Array<Int> = new Array<Int>(); 
		for (i in 0...num)
		{
			result.push(i);
		}
		return result;
	}

	public override function getVFX(i:Int, vfx:FlxSprite)
	{
		switch (i)
		{
			case 0:
				vfx.loadGraphic(Paths.image('note_effects/fire/left', 'mods'), true, 256, 256);

			case 1:
				vfx.loadGraphic(Paths.image('note_effects/fire/down', 'mods'), true, 256, 256);

			case 2:
				vfx.loadGraphic(Paths.image('note_effects/fire/up', 'mods'), true, 256, 256);

			case 3:
				vfx.loadGraphic(Paths.image('note_effects/fire/right', 'mods'), true, 256, 256);

		}

		vfx.ID = i;
		vfx.animation.add('hit', getArray(60), 90, false);

		vfx.x -= 75;
		vfx.y -= 75;

		vfx.antialiasing = true;
		vfx.setGraphicSize(Std.int(vfx.width * 3));
	}
}