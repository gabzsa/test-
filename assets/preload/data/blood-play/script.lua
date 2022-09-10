function onCreate()
    precacheImage("characters/human-enemy");

    makeLuaSprite("black_fade", "stages/playground/black_fade", screenX, screenY);
    setObjectCamera("black_fade", "other");
    setProperty("black_fade.alpha", 0);
    addLuaSprite("black_fade", false);

    makeAnimatedLuaSprite("human_enemy_front", "stages/playground/human_enemy_front", -150, 450);
    addAnimationByPrefix("human_enemy_front", "idle", "HumanEnemyFrontIdle", 24, false);
    setScrollFactor("human_enemy_front", 1.5, 1.5);
    scaleObject("human_enemy_front", 0.8, 0.8);
    setProperty("human_enemy_front.alpha", 0);
    addLuaSprite("human_enemy_front", true);
end

function onBeatHit()
    if curBeat % 2 == 0 then
	    objectPlayAnimation("human_enemy_front", "idle", true);
	end
end

function onStepHit()
    if curStep == 64 then
        setProperty("defaultCamZoom", 0.9);
    end
	if curStep == 252 then
		doTweenZoom("CameraTweenZoom", "camGame", 1, 5, "quadInOut");
    end
    if curStep == 256 then
		setProperty("defaultCamZoom", 0.7);
    end
    if curStep == 316 then
		doTweenZoom("CameraTweenZoom", "camGame", 1, 5, "quadInOut");
    end
    if curStep == 480 then
		setProperty("human_enemy_front.alpha", 1);
    end
    if curStep == 512 then
		setProperty("defaultCamZoom", 0.9);
    end
    if curStep == 624 then
        setProperty("defaultCamZoom", 0.7);
        setProperty("human_dies.alpha", 1);
        objectPlayAnimation("human_dies", "shot", true);
        setProperty("human_enemy_front.alpha", 0);
        doTweenZoom("CameraTweenZoom", "camGame", 1, 3, "quadInOut");
        setProperty("blood.alpha", 1);
    end
    if curStep == 628 then
		doTweenAlpha("HudAlpha", "camHUD", 0, 1, "linear")
    end
    if curStep == 648 then
		doTweenAlpha("HudAlpha", "camHUD", 1, 1, "linear")
    end
    if curStep == 784 then
		setProperty("defaultCamZoom", 0.7);
    end
    if curStep == 1040 then
		setProperty("defaultCamZoom", 0.9);
    end
    if curStep == 1168 then
		setProperty("defaultCamZoom", 0.7);
    end
    if curStep == 1424 then
		setProperty("defaultCamZoom", 0.8);
    end
    if curStep == 1548 then
        doTweenAlpha("EndScreenFade", "black_fade", 1, 2);
    end
end