extends GameObject
class_name Unlockable

signal unlocked

export(String) var key = ""

var is_locked: bool = true


func _ready() -> void:
	assert(key != "", "No key set, Object can't be opened!")


func _on_Unlockable_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		if not is_locked:
			return  # If already unlocked, return
		
		if Gamestate.selected_item == key:
			yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
			is_locked = false
			emit_signal("unlocked")
