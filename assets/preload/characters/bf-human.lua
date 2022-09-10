function onCreate()
	setPropertyFromClass("GameOverSubstate", "characterName", "bf-human-dead");
	setPropertyFromClass("GameOverSubstate", "deathSoundName", "fnf_loss_sfx");
	setPropertyFromClass("GameOverSubstate", "loopSoundName", "gameOver");
	setPropertyFromClass("GameOverSubstate", "endSoundName", "gameOverEnd");
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == "BulletNote" then
		setPropertyFromClass("GameOverSubstate", "characterName", "bf-human-dead-bullet");
		runTimer("bullet_death", 0.1, 1);
	end
end

function onGameOverStart()
	if getPropertyFromClass("GameOverSubstate", "characterName") == "bf-human-dead-bullet" then
		playSound("bullet", 0.6);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "bullet_death" then
		setPropertyFromClass("GameOverSubstate", "characterName", "bf-human-dead");
	end
end