extends Clickable
class_name Focusable

signal focused

export(NodePath) var _focus_point_path = @"FocusPoint"
export(float) var focus_zoom = 4.0

onready var focus_point: Position2D = get_node(_focus_point_path)

var is_focused: bool setget , get_is_focused

func get_is_focused() -> bool:
	return Gamestate.focused_object == object_name


func _ready() -> void:
	assert(focus_point != null, "No Focus Point found, please check Focus Point Path!")
	assert(focus_zoom > 0, "Focus zoom cannot be negative or zero!")




func _on_clicked() -> void:
		# If object already focused, do nothing
		if self.is_focused:
			return
			
		yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
										# Otherwise, subobjects can be clicked while this object is not focused
		Gamestate.focused_object = object_name  # Focus on this object
		propagate_call("set_disabled", [false])
		emit_signal("focused")
