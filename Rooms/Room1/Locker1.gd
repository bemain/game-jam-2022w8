extends Unlockable


signal opened


func _on_unlocked():
	$Lock/AnimatedSprite.animation = "Unlocked"


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		if is_locked:
			return
		
		emit_signal("opened")


func _on_opened():
	$Sprite.visible = true
	$Lock.position = Vector2(0, 360)
	$Lock.rotation_degrees = 90
	$Lock/AnimatedSprite.animation = "On floor"

