extends GameObject
class_name Focusable

signal focused

export(NodePath) var _focus_point_path = @"FocusPoint"
export(float) var focus_zoom = 4

onready var focus_point = get_node(_focus_point_path)

var is_focused setget , get_is_focused

func get_is_focused():
	return Gamestate.focused_object == object_name


func _ready():
	assert(focus_point != null, "No Focus Point found, please check Focus Point Path!")
	assert(focus_zoom > 0, "Focus zoom cannot be negative or zero!")


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
