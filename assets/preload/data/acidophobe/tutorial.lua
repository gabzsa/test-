local stop_countdown = true
local tutorial = false
function onCreatePost()
	if not seenCutscene then
		makeLuaSprite("tutorial", "acidophobe/tutorial", screenX, screenY);
		setObjectCamera("tutorial", "other");
		setProperty("tutorial.alpha", 0);
    	addLuaSprite("tutorial", true);
		
		setProperty("camHUD.alpha", 0);
	end
end

function onStartCountdown()
	if stop_countdown and not seenCutscene then
		setProperty("inCutscene", true);
		runTimer("TutorialPopUp", 1, 1);
		return Function_Stop
	end
	return Function_Continue
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "TutorialPopUp" then
		doTweenAlpha("TutorialFadeIn", "tutorial", 1, 1, "quartinout");
	end
	if tag == "TutorialClose" then
		stop_countdown = false
		setProperty("inCutscene", false);
		runHaxeCode("game.startCountdown();");
		doTweenAlpha("HudFadeIn", "camHUD", 1, 2, "cubeout");
	end
end

function onTweenCompleted(tag)
	if tag == "TutorialFadeIn" then
		tutorial = true;
	end
end

function onUpdatePost(elapsed)
	if stop_countdown and not seenCutscene then
		if tutorial then
			for _, key in pairs({"SPACE", "ENTER", "ESCAPE"}) do
				if getPropertyFromClass("flixel.FlxG", "keys.justPressed." .. key) then
					tutorial = false
					doTweenAlpha("TutorialFadeOut", "tutorial", 0, 1, "quartinout");
					runTimer("TutorialClose", 1, 1);
					playSound("confirmMenu");
				end
			end
		end
	end
end