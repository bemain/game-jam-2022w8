extends Camera2D

signal selected_wall_changed

export(float) var focus_speed := 0.2

onready var animation_player: AnimationPlayer = get_tree().root.get_node("World/AnimationPlayer")

var selected_wall: int = 0 setget set_selected_wall

func set_selected_wall(value: int) -> void:
	selected_wall = fposmod(value, 4)
	animation_player.play("Fade")


func _input(event: InputEvent) -> void:
	if not Gamestate.focused_object:  # Block movement if focused
		if event.is_action_pressed("ui_right"):
			self.selected_wall += 1
		if event.is_action_pressed("ui_left"):
			self.selected_wall -= 1
	if event.is_action_pressed("ui_down"):
		Gamestate.focused_object = ""

func _process(delta: float) -> void:
	var target_offset := Vector2.ZERO
	var target_zoom := Vector2(1, 1)
	if Gamestate.focused_object:  # Focus on focused object, if any 
		var focused_node: Focusable = Gamestate.objects[Gamestate.focused_object]
		target_offset = focused_node.focus_point.global_position - global_position
		target_zoom /= focused_node.focus_zoom
	# Interpolate towards target
	offset = lerp(offset, target_offset, focus_speed)
	zoom = lerp(zoom, target_zoom, focus_speed)


func on_wall_changed() -> void:
	emit_signal("selected_wall_changed")
	position = Vector2(selected_wall * Constants.wallsize.x, 0) + Constants.wallsize / 2  # Update position
