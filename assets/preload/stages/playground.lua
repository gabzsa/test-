function onCreate()
    makeLuaSprite("playground_back", "stages/playground/playground_back", -310, -330);
    addLuaSprite("playground_back", false);

    makeLuaSprite("ground", "stages/playground/ground", -310, 775);
    addLuaSprite("ground", false);

    makeLuaSprite("blood", "stages/playground/blood", -65, 770);
    setProperty("blood.alpha", 0);
    addLuaSprite("blood", false);

    makeAnimatedLuaSprite("human_dies", "stages/playground/human_dies", -150, 75);
	addAnimationByPrefix("human_dies", "shot", "HumanShot", 24, false);
    setProperty("human_dies.alpha", 0);
    addLuaSprite("human_dies", false);
end