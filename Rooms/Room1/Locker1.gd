extends Node2D


signal opened

var is_open: bool = false


func _ready() -> void:
	$LockFocus/Lock/AnimatedSprite.animation = "Locked"
	$Sprite.visible = false
	$TopShelf.is_clickable = false  # Disable shelves
	$BottomShelf.is_clickable = false


func _on_Lock_unlocked() -> void:
	$LockFocus/Lock/AnimatedSprite.animation = "Unlocked"
	$TopShelf.is_clickable = true  # Enable shelves
	$BottomShelf.is_clickable = true
	$LockFocus.is_clickable = false  # Disable LockFocus
	
	$SoundEffectPlayer.play_effect("LockSound")  # Play sound effect


func _on_shelf_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		# If Lock is clicked while already unlocked, open the locker
		if $LockFocus/Lock.is_locked or is_open:
			return
		yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
		is_open = true
		emit_signal("opened")


func _on_opened() -> void:
	$Sprite.visible = true
	$LockFocus/Lock.position = Vector2(0, 380)  # Position Lock on the floor
	$LockFocus/Lock.rotation_degrees = 90
	$LockFocus/Lock/AnimatedSprite.animation = "On floor"
	
	$SoundEffectPlayer.play_effect("LockerOpenSound")  # Play sound effect

