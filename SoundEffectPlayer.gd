extends AudioStreamPlayer2D
tool


export(Dictionary) var sounds = get_sounds()


func get_sounds() -> Dictionary:
	var sounds := {}
	var path := "res://Resources/SoundEffects/"
	var dir := Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file: String = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.get_extension() == "mp3":
			var sound := load(path + file) as AudioStreamMP3
			sound.loop = false
			sounds[file.get_basename()] = sound
			
	dir.list_dir_end()
	
	return sounds


func play_effect(effect: String):
	if not effect in sounds.keys():
		print("Sound effect not found: " + effect)
		return
	
	if playing:
		print("Already playing, sound effect " + effect + " skipped")
		return
	
	stream = sounds[effect]
	play()
