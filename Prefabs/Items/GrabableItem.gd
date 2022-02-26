extends Node2D

export(String) var item_name = "GrabableItem_TEST"


func _ready():
	# Register item
	assert(not item_name in Gamestate.items, "ERROR: Duplicate, item already exists: " + item_name)
	Gamestate.items[item_name] = self


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		Gamestate.inventory_items.append(item_name)
		Gamestate.selected_item = item_name
		queue_free()
