extends GameObject
class_name Unlockable
tool

signal unlocked

export(String) var key = ""

var is_locked = true


func _on_Lock_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		if not is_locked:
			return  # If already unlocked, return
		
		if Gamestate.focused_object != object_name:
			return  # If object isn't focused, return
		
		if Gamestate.selected_item == key:
			is_locked = false
			emit_signal("unlocked")

func _get_configuration_warning():
	if key == "":
		return "No key item has been set for this node, so it can't be opened."
	return ""
