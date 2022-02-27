extends Area2D
class_name FocusOnClick

signal focused

export(NodePath) var parent_object_path = @".."

onready var parent_object = get_node(parent_object_path)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		# If object already focused, do nothing
		if Gamestate.focused_object == parent_object.object_name:
			return
			
		yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
										# Otherwise, subobjects can be clicked while this object is not focused
		Gamestate.focused_object = parent_object.object_name  # Focus on this object
		emit_signal("focused")
