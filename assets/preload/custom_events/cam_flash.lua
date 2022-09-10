function onEvent(name, value1, value2)
    if name == "cam_flash" then
		cameraFlash("camGame", "ffffff", 0.15, true);
		cameraShake("camGame", 0.015, 0.15);
	end
end