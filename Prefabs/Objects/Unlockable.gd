extends Area2D
class_name Unlockable
tool

signal unlocked

export(NodePath) var parent_object_path = @".."
export(String) var key = ""
export(bool) var require_focus = true

onready var parent_object = get_node(parent_object_path)

var is_locked = true


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		if not is_locked:
			return  # If already unlocked, return
		
		if require_focus and Gamestate.focused_object != parent_object.object_name:
			return  # If object isn't focused, return
		
		if Gamestate.selected_item == key:
			emit_signal("unlocked")

func _get_configuration_warning():
	if key == "":
		return "No key item has been set for this node, so it can't be opened."
	return ""
