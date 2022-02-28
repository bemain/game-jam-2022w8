extends Unlockable


export(NodePath) var lock_focus_path = @"LockFocus"

onready var lock_focus = get_node(lock_focus_path)


# Override Unlockable's input to add extra focus check
func _on_Unlockable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		if not is_locked:
			return  # If already unlocked, return
		
		if not lock_focus.is_focused:
			return  # Make sure object is focused
		
		if Gamestate.selected_item == key:
			yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
			is_locked = false
			emit_signal("unlocked")

