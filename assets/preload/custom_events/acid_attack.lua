local hit = 0
local acid_attack = false;
function onCreatePost()
	precacheImage("ui/acidophobe/arrow");
    precacheImage("ui/acidophobe/arrow_hit");
    precacheImage("ui/acidophobe/acid_tank");

    makeAnimatedLuaSprite("acid_spit", "acidophobe/acid_spit", 825, 485);
    addAnimationByPrefix("acid_spit", "dodge", "AcidDodge", 24, false);
    addAnimationByPrefix("acid_spit", "hit", "AcidHit", 24, false);
    setProperty("acid_spit.alpha", 0);
	addLuaSprite("acid_spit", true);

    makeLuaSprite("arrow", "ui/acidophobe/arrow", 860, 375);
    setObjectCamera("arrow", "hud");
    scaleObject("arrow", 0.9, 0.9);
    setProperty("arrow.alpha", 0);
	addLuaSprite("arrow", true);

    makeAnimatedLuaSprite("arrow_hit", "ui/acidophobe/arrow_hit", 860, 375);
    addAnimationByPrefix("arrow_hit", "hit", "AcidArrowHit", 24, false);
    setObjectCamera("arrow_hit", "hud");
    scaleObject("arrow_hit", 0.9, 0.9);
    setProperty("arrow_hit.alpha", 0);
	addLuaSprite("arrow_hit", true);

    makeAnimatedLuaSprite("acid_tank", "ui/acidophobe/acid_tank", 710, 200);
    addAnimationByPrefix("acid_tank", "idle", "AcidTank0", 24, true);
    addAnimationByPrefix("acid_tank", "hit", "AcidTankHit", 24, true);
    setObjectCamera("acid_tank", "hud");
    scaleObject("acid_tank", 0.9, 0.9);
    setProperty("acid_tank.alpha", 0);
	addLuaSprite("acid_tank", true);
end

function onUpdatePost()
    if acid_attack == true and getPropertyFromClass("flixel.FlxG", "keys.justPressed.SPACE") then
        setProperty("arrow.alpha", 0);
        setProperty("arrow_hit.alpha", 1);
        setProperty("arrow_hit.y", getProperty("arrow.y"));
        objectPlayAnimation("arrow_hit", "hit", true);
        cancelTimer("acid_attack_timer");

        if hit == 0 then
            if getProperty("arrow_hit.y") > 365 then
                hit = 1;
            end
            if getProperty("arrow_hit.y") > 265 and getProperty("arrow_hit.y") < 365 then
                hit = 2;
            end
            if getProperty("arrow_hit.y") < 265 then
                hit = 3;
            end
        end
        if hit == 1 then
            objectPlayAnimation("acid_tank", "hit", true);
            characterPlayAnim("dad", "spit", true);
            setProperty("acid_spit.alpha", 1);
            objectPlayAnimation("acid_spit", "hit", true);
            setProperty("acid_spit.x", 950);
            setProperty("acid_spit.y", 485);
            playSound("acid_hit", 0.4);
            runTimer("acid_melt", 0.1, 10);
            characterPlayAnim("boyfriend", "hurt", true);
        end
        if hit == 2 then
            objectPlayAnimation("acid_tank", "hit", true);
            characterPlayAnim("dad", "spit", true);
            setProperty("acid_spit.alpha", 1);
            objectPlayAnimation("acid_spit", "hit", true);
            setProperty("acid_spit.x", 950);
            setProperty("acid_spit.y", 485);
            playSound("acid_hit", 0.4);
            runTimer("acid_melt", 0.1, 5);
            characterPlayAnim("boyfriend", "hurt", true);
        end
        if hit == 3 then
            objectPlayAnimation("acid_tank", "hit", true);
            characterPlayAnim("dad", "spit", true);
            setProperty("acid_spit.alpha", 1);
            objectPlayAnimation("acid_spit", "dodge", true);
            setProperty("acid_spit.x", 1000);
            setProperty("acid_spit.y", 485);
            characterPlayAnim("boyfriend", "dodge", true);
            playSound("acid_dodged", 0.4);
        end

        doTweenAlpha("AcidTankFadeOut", "acid_tank", 0, 1, "quartin");
        doTweenAlpha("ArrowHitFadeOut", "arrow_hit", 0, 1, "circin");
        cancelTween("ArrowTweenYUp");
        cancelTween("ArrowTweenYDown");

        acid_attack = false;
        hit = 0;
    end
end

function onEvent(name, value1, value2)
    if name == "acid_attack" then
        acid_attack = true;
        runTimer("acid_attack_timer", (4 * (1 / (getPropertyFromClass("Conductor", "bpm") / 60))) - 2.5, 0);
        setProperty("arrow.y", 375);
        doTweenAlpha("AcidTankFadeIn", "acid_tank", 1, 0.25, "circin");
        doTweenAlpha("ArrowFadeIn", "arrow", 1, 0.25, "circin");
        objectPlayAnimation("acid_tank", "idle", true);
        doTweenY("ArrowTweenYUp", "arrow", 235, (4 * (1 / (getPropertyFromClass("Conductor", "bpm") / 60))) - 2, "backinout");
    end
end

function onTweenCompleted(tag)
	if tag == "ArrowTweenYUp" and acid_attack == true then
		doTweenY("ArrowTweenYDown", "arrow", 445, (4 * (1 / (getPropertyFromClass("Conductor", "bpm") / 60))) - 1, "backinout");
	end
    if tag == "ArrowTweenYDown" and acid_attack == true then
		doTweenY("ArrowTweenYUp", "arrow", 235, (4 * (1 / (getPropertyFromClass("Conductor", "bpm") / 60))) - 1, "backinout");
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "acid_melt" then
		setProperty("health", getProperty("health") -0.1);
	end
    if tag == "acid_attack_timer" and acid_attack == true then
        acid_attack = false;
        setProperty("arrow.alpha", 0);
        setProperty("arrow_hit.alpha", 1);
        setProperty("arrow_hit.y", getProperty("arrow.y"));
        objectPlayAnimation("arrow_hit", "hit", true);

        objectPlayAnimation("acid_tank", "hit", true);
        characterPlayAnim("dad", "spit", true);
        setProperty("acid_spit.alpha", 1);
        objectPlayAnimation("acid_spit", "hit", true);
        setProperty("acid_spit.x", 950);
        setProperty("acid_spit.y", 485);
        playSound("acid_hit", 0.4);
        runTimer("acid_melt", 0.1, 5);

        doTweenAlpha("AcidTankFadeOut", "acid_tank", 0, 1, "quartin");
        doTweenAlpha("ArrowHitFadeOut", "arrow_hit", 0, 1, "circin");
        cancelTween("ArrowTweenYUp");
        cancelTween("ArrowTweenYDown");
    end
end