extends AudioStreamPlayer




func _ready():
	Gamestate.connect("current_day_changed", self, "on_current_day_changed")  # Listen for changes to current day
	on_current_day_changed(Gamestate.current_day)  # Trigger initial update


func on_current_day_changed(current_day):
	# Play corresponding soundtrack
	stream = load("res://Resources/Music/Day%d.mp3" % (current_day + 1))
	play()

