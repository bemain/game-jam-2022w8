extends GameObject
class_name Focusable

signal focused

export(float) var focus_zoom = 2

var is_focused setget , get_is_focused

func get_is_focused():
	return Gamestate.focused_object == object_name


func _on_Focusable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		# If object already focused, do nothing
		if self.is_focused:
			return
			
		yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
										# Otherwise, subobjects can be clicked while this object is not focused
		Gamestate.focused_object = object_name  # Focus on this object
		emit_signal("focused")
