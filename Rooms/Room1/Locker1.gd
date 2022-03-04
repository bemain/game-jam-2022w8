extends GameObject


signal opened

var is_open = false


func _ready():
	$Lock/AnimatedSprite.animation = "Locked"
	$Sprite.visible = false
	$TopShelf.visible = false  # Hide shelves
	$BottomShelf.visible = false
	$BottomShelf/Items.visible = false


func _on_Lock_unlocked():
	$Lock/AnimatedSprite.animation = "Unlocked"
	$TopShelf.visible = true  # Enable shelves
	$BottomShelf.visible = true
	$Lock/LockFocus.visible = false  # Disable lock focus
	
	$SoundEffectPlayer.play_effect("LockSound")  # Play sound effect


func _on_shelf_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		# If Lock is clicked while already unlocked, open the locker
		if $Lock.is_locked or is_open:
			return
		yield(get_tree(),"idle_frame")  # Wait one frame before focusing to let input pass to children first
		is_open = true
		emit_signal("opened")


func _on_opened():
	$Sprite.visible = true
	$Lock.position = Vector2(0, 380)  # Position Lock on the floor
	$Lock.rotation_degrees = 90
	$Lock/AnimatedSprite.animation = "On floor"
	
	$BottomShelf/Items.visible = true
	
	$SoundEffectPlayer.play_effect("LockerOpenSound")  # Play sound effect

