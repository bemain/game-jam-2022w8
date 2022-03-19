extends Clickable
class_name Focusable

signal focused
signal defocused

export(NodePath) var _focus_point_path = @"FocusPoint"
export(float) var focus_zoom = 4.0

onready var focus_point: Position2D = get_node(_focus_point_path)

var is_focused: bool setget , get_is_focused

func get_is_focused() -> bool:
	return Gamestate.focused_object == object_name


func _ready() -> void:
	assert(focus_point != null, "No Focus Point found, please check Focus Point Path!")
	assert(focus_zoom > 0, "Focus zoom cannot be negative or zero!")
	
	# Listen for when focused object changes
	Gamestate.connect("focused_object_changed", self, "_on_focused_object_changed")
	# Make children not clickable
	for child in get_children():
		child.propagate_call("set_is_clickable", [false])


func _on_clicked() -> void:
	# If object already focused, do nothing
	if self.is_focused:
		return
		
	yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
									# Otherwise, subobjects can be clicked while this object is not focused
	Gamestate.focused_object = object_name  # Focus on this object
	# Make children clickable
	for child in get_children():
		child.propagate_call("set_is_clickable", [true])
	
	emit_signal("focused")


func _on_focused_object_changed(previous: String, current: String) -> void:
	if previous == object_name and current != object_name:
		# Make children not clickable
		for child in get_children():
			child.propagate_call("set_is_clickable", [false])
		
		emit_signal("defocused")
