extends Area2D
class_name GameObject

signal clicked

export(String) var object_name = ""

var is_clickable: bool = true setget set_is_clickable

func set_is_clickable(value: bool) -> void:
	is_clickable = value


func _ready() -> void:
	assert(object_name, "Object has no name.")
	assert(not object_name in Gamestate.objects, "Duplicate, object already exists: " + object_name)
	
	Gamestate.objects[object_name] = self  # Register item


func _on_Clickable_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		if is_clickable:
			emit_signal("clicked")
