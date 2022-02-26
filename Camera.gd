extends Camera2D

enum {WALL, CEILING}

var selected_wall: int = 0 setget set_selected_wall
var selected_type = WALL

func set_selected_wall(value):
	selected_wall = fposmod(value, 4)


func _input(event):
	if event.is_action_pressed("ui_right"):
		selected_wall += 1
	if event.is_action_pressed("ui_left"):
		selected_wall -= 1
	if event.is_action_pressed("ui_up"):
		selected_type = CEILING
	if event.is_action_pressed("ui_down"):
		selected_type = WALL
