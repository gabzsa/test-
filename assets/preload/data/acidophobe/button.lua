function onCreate()

	makeAnimatedLuaSprite('dodge', 'virtualbuttons', 1150, 582.5);
	addAnimationByPrefix('dodge', 'anonPress', 'anonPress', 24, false);
	addAnimationByPrefix('dodge', 'aPressed', 'aPressed', 12, false);
	addLuaSprite('dodge', false);
	setObjectCamera('dodge', 'other');

end

function onUpdate()
	if (getMouseX('camHUD') > 1150 and getMouseX('camHUD') < 1280) and (getMouseY('camHUD') > 582.5 and getMouseY('camHUD') < 720 and mousePressed('left')) or keyReleased('space') then
		objectPlayAnimation('dodge', 'aPressed', false);
	else
		objectPlayAnimation('dodge', 'anonPress', false);
	end
end
