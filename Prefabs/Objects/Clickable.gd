extends GameObject
class_name Clickable

signal clicked

var is_clickable: bool = true setget set_is_clickable

func set_is_clickable(value: bool) -> void:
	is_clickable = value


func _on_Clickable_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		if is_clickable:
			emit_signal("clicked")
