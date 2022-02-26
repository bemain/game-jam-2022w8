extends Camera2D

enum {WALL, CEILING}

export(float) var focus_speed = 0.2

var selected_wall: int = 0 setget set_selected_wall
var selected_type = WALL setget set_selected_type

var _target_pos

func set_selected_wall(value):
	selected_wall = fposmod(value, 4)
	on_wall_changed()

func set_selected_type(value):
	selected_type = value
	on_wall_changed()


func _input(event):
	if selected_type == WALL and not Gamestate.focused_object:
		if event.is_action_pressed("ui_right"):
			self.selected_wall += 1
		if event.is_action_pressed("ui_left"):
			self.selected_wall -= 1
		if event.is_action_pressed("ui_up"):
			self.selected_type = CEILING
	
	if event.is_action_pressed("ui_down"):
		self.selected_type = WALL
		Gamestate.focused_object = null


func _process(delta):
	var target_offset = Vector2.ZERO
	var target_zoom = Vector2(2, 2)
	if Gamestate.focused_object:  # Focus on focused object, if any 
		var focused_node: Node2D = Gamestate.objects[Gamestate.focused_object]
		target_offset = focused_node.global_position - global_position
		target_zoom /= 4
	# Interpolate towards target
	offset = lerp(offset, target_offset, focus_speed)
	zoom = lerp(zoom, target_zoom, focus_speed)
	


func on_wall_changed():
	match selected_type:
		WALL:
			position = Vector2(selected_wall * Constants.wallsize.x, 0)
		CEILING:
			position = Vector2(0, Constants.wallsize.y)
