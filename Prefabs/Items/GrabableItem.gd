extends Node2D

export(String) var item_name = "Test"


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		Gamestate.items.append(item_name)
		queue_free()
