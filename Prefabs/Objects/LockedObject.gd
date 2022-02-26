extends Node2D

export(String) var object_name = "LockedObject_TEST"
export(String) var key = "Key_TEST"


func _ready():
	# Register item
	assert(not object_name in Gamestate.objects, "ERROR: Duplicate, item already exists: " + object_name)
	Gamestate.objects[object_name] = self


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		# Check if correct item is used
		if Gamestate.selected_item == key:
			queue_free()
