extends Camera

enum {WALL, CEILING}

export(float) var rotate_speed = 0.1

var selected_wall = 0 setget set_selected_wall
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


func _process(delta):
	var target_rotation = Vector3.ZERO
	target_rotation.x = PI / 2 if selected_type == CEILING else 0.0
	target_rotation.y = selected_wall * -PI / 2 + PI
	
	rotation = lerp(rotation, target_rotation, rotate_speed)
