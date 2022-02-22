extends Camera2D

enum {WALL, CEILING}

onready var screensize = get_viewport().size

var selected_wall = 0 setget set_selected_wall
var selected_type = WALL


func set_selected_wall(value):
	selected_wall = fposmod(value, 4)


func _input(event):
	# Block movement if already moving
	if (position - get_camera_screen_center()).length() > 10:
		return
	match selected_type:
		WALL:
			if event.is_action_pressed("ui_right"):
				move(Vector2.RIGHT)
			if event.is_action_pressed("ui_left"):
				move(Vector2.LEFT)
			if event.is_action_pressed("ui_up"):
				selected_type = CEILING
				move(Vector2.UP)
		CEILING:
			if event.is_action_pressed("ui_down"):
				selected_type = WALL
				move(Vector2.DOWN)


func move(direction: Vector2):
	# Move
	var target_pos = position + screensize * direction
	position = target_pos
	# Set position of wall / ceiling
	if direction.x:
		self.selected_wall += direction.x
		get_node("../Room").get_node("Wall" + str(selected_wall + 1)).position.x = target_pos.x
	if direction.y:
		get_node("../Room").get_node("Ceiling").position.x = target_pos.x
	
