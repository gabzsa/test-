local event = false;
local killed = false;
local ended = false;
function onCreatePost()
	precacheImage("characters/gorse");
	precacheImage("acidophobe/human_acid_hit");
	precacheImage("acidophobe/acid_spit");
	precacheImage("acidophobe/limbs/human_1");
	precacheImage("acidophobe/limbs/human_2");
	precacheImage("acidophobe/limbs/human_3");
	precacheImage("acidophobe/limbs/human_4");

	setProperty("defaultCamZoom", 1.1);

	for i1, victim in pairs({"human"}) do
		for i2 = 1, 4 do
			local sprite = victim .. i2;
			makeLuaSprite(sprite, "acidophobe/limbs/" .. victim .. "_" .. i2, -25 + 540 * (i1), 150 + i2 * 150);
			setProperty(sprite .. ".alpha", 0);
			addLuaSprite(sprite, true);
		end
	end
	
	makeAnimatedLuaSprite("acid_spit_human", "acidophobe/acid_spit", 50, 475);
    addAnimationByPrefix("acid_spit_human", "hit", "AcidHit", 24, false);
    setProperty("acid_spit_human.alpha", 0);
	addLuaSprite("acid_spit_human", false);

	makeAnimatedLuaSprite("human_acid_hit", "acidophobe/human_acid_hit", 430, 305);
	addAnimationByPrefix("human_acid_hit", "acid_hit", "HumanAcidHit", 24, false)
	setProperty("human_acid_hit.alpha", 0);
	addLuaSprite("human_acid_hit", true);
end

local floor = math.floor
function onUpdatePost()
	local song_pos = getSongPosition();
	if killed and not ended then
		for _, victim in pairs({"human"}) do
			for i = 1, 4 do
				local sprite = victim .. i;
				setProperty(sprite .. ".angle", floor(song_pos / 125) * 45 * i);
			end
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "HumanBones" then
		killed = true;
		for _, victim in pairs({"human"}) do
			for i = 1, 4 do
				local sprite = victim .. i;
				setProperty(sprite .. ".alpha", 1);
				setProperty(sprite .. ".acceleration.y", 2000);
				setProperty(sprite .. ".velocity.y", getRandomInt(-1000, -500));
				setProperty(sprite .. ".velocity.x", getRandomInt(-500, 500));
			end
		end
		runTimer("BonesCleanup", 5);
	end
	if tag == "BonesCleanup" then
		ended = true;
		for _, victim in pairs({"human"}) do
			for i = 1, 4 do
				removeLuaSprite(victim .. i);
			end
		end
	end
end

function onStepHit()
	if curStep == 256 then
		setProperty("defaultCamZoom", 0.9);
	end
	if curStep == 540 then
		setProperty("dad.alpha", 1);
	end
	if curStep == 512 then
		setProperty("defaultCamZoom", 1.2);
	end
	if curStep == 512 then
		setProperty("defaultCamZoom", 0.9);
	end
	if curStep == 544 then
		setProperty("defaultCamZoom", 1.0);
	end
	if curStep == 672 then
		setProperty("defaultCamZoom", 0.9);
	end
	if curStep == 984 then
		setProperty("defaultCamZoom", 0.7);
	end
	if curStep == 992 then
		setProperty("defaultCamZoom", 1.0);
	end
	if curStep == 1248 then
		setProperty("defaultCamZoom", 0.9);
	end
	if curStep == 1376 then
		setProperty("defaultCamZoom", 1.0);
	end
	if curStep == 1504 then
		setProperty("defaultCamZoom", 0.7);
	end
end

function onBeatHit()
	if curBeat == 134 then
		setProperty("acid_spit_human.alpha", 1);
		objectPlayAnimation("acid_spit_human", "hit", true);
		setProperty("dad.alpha", 0);
		setProperty("human_acid_hit.alpha", 1);
		objectPlayAnimation("human_acid_hit", "acid_hit", true);
	end
	if curBeat == 135 then
		event = true;
		runTimer("HumanBones", 0.06);
	end
end