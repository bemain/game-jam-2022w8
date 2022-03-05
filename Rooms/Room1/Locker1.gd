extends GameObject


signal opened

var is_open: bool = false


func _ready() -> void:
	$Lock/AnimatedSprite.animation = "Locked"
	$Sprite.visible = false
	$TopShelf.visible = false
	$BottomShelf.visible = false


func _on_Lock_unlocked() -> void:
	$Lock/AnimatedSprite.animation = "Unlocked"
	$TopShelf.visible = true  # Enable shelves
	$BottomShelf.visible = true
	$Lock/LockFocus.visible = false  # Disable lock focus
	
	$SoundEffectPlayer.play_effect("LockSound")  # Play sound effect


func _on_shelf_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		# If Lock is clicked while already unlocked, open the locker
		if $Lock.is_locked or is_open:
			return
		yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
		is_open = true
		emit_signal("opened")


func _on_opened() -> void:
	$Sprite.visible = true
	$Lock.position = Vector2(0, 380)  # Position Lock on the floor
	$Lock.rotation_degrees = 90
	$Lock/AnimatedSprite.animation = "On floor"
	
	$SoundEffectPlayer.play_effect("LockerOpenSound")  # Play sound effect

