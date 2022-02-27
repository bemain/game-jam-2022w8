extends Focusable
class_name Unlockable

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
			yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
			is_locked = false
			emit_signal("unlocked")
