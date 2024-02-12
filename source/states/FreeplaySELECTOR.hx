package states;


class FreeplaySELECTOR extends MusicBeatState
{
    var story:FlxSprite;
    var other:FlxSprite;

    var curSelected:Int = 0;

    override function create()
        {
            #if desktop
            // Updating Discord Rich Presence
            DiscordClient.changePresence("FreePlay Selector", null);
            #end

            persistentUpdate = true;

            var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
            bg.antialiasing = ClientPrefs.data.antialiasing;
            bg.scrollFactor.set(0, 0);
            bg.setGraphicSize(Std.int(bg.width * 1.175));
            bg.updateHitbox();
            bg.screenCenter();
            add(bg);

            story = new FlxSprite(-100, -80);
            story.frames = Paths.getSparrowAtlas('freeplay/menu_Story');
            story.animation.addByPrefix('basic', 'basic', 24, true);
            story.animation.addByPrefix('white', 'white', 24, true);
            story.animation.play('basic');
            add(story);

            other = new FlxSprite(-400, -10);
            other.frames = Paths.getSparrowAtlas('freeplay/menu_Extras');
            other.animation.addByPrefix('basic', 'basic', 24, true);
            other.animation.addByPrefix('white', 'white', 24, true);
            other.animation.play('basic');
            add(other);
        }
    override function update(elapsed:Float)
        {
            if (controls.UI_LEFT_P)
                {
                    sellama(-1);
                }
                else if (controls.UI_RIGHT_P)
                {
                    sellama(1);
                }


            if (curSelected == 0)
                {
                    story.animation.play('white');
                    if (controls.ACCEPT)
                        MusicBeatState.switchState(new FreeplayState());
                }
            else
                {
                    story.animation.play('basic');
                }
                
            if (curSelected == 1)
                {
                    other.animation.play('white');
                }
            else
                {
                    other.animation.play('basic');
                }
            super.update(elapsed);
        }

    function sellama(sellama:Int)
        {
            curSelected += sellama;

            if (curSelected < 0)
                curSelected = 0;
            if (curSelected >= 1)
                curSelected = 1;
        }
}