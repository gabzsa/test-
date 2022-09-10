function onCreate()
	for i = 0, getProperty("unspawnNotes.length")-1 do
		if getPropertyFromGroup("unspawnNotes", i, "noteType") == "BulletNote" then
			setPropertyFromGroup("unspawnNotes", i, "texture", "notes/bullet_note");
			setPropertyFromGroup("unspawnNotes", i, "hitCausesMiss", false);
			if getPropertyFromGroup("unspawnNotes", i, "mustPress") then
				setPropertyFromGroup("unspawnNotes", i, "ignoreNote", false);
			end
		end
	end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == "BulletNote" then
	    characterPlayAnim("dad", "shoot", true);
		characterPlayAnim("boyfriend", "bulletDodge", true);
		characterPlayAnim("gf", "dodge", true);
		cameraShake("camGame", 0.03, 0.01);
		playSound("bullet", 0.6);
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == "BulletNote" then
	    characterPlayAnim("dad", "shoot", true);
		characterPlayAnim("boyfriend", "hurt", true);
		characterPlayAnim("gf", "dodge", true);
		setProperty("health", getProperty("health") -0.25);
	end
end