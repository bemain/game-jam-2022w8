extends Node2D

export(String) var key = "Key"


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		# Check if correct item is used
		if Gamestate.selected_item == key:
			queue_free()
