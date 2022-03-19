extends GameObject
class_name Clickable

signal clicked


func _on_Clickable_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		emit_signal("clicked")
