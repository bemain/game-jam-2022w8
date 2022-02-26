extends Camera2D

enum {WALL, CEILING}

var selected_wall: int = 0 setget set_selected_wall
var selected_type = WALL setget set_selected_type

func set_selected_wall(value):
	selected_wall = fposmod(value, 4)
	on_wall_changed()

func set_selected_type(value):
	selected_type = value
	on_wall_changed()


func _input(event):
	match selected_type:
		WALL:
			if event.is_action_pressed("ui_right"):
				self.selected_wall += 1
			if event.is_action_pressed("ui_left"):
				self.selected_wall -= 1
			if event.is_action_pressed("ui_up"):
				self.selected_type = CEILING
		CEILING:
			if event.is_action_pressed("ui_down"):
				self.selected_type = WALL


func on_wall_changed():
	match selected_type:
		WALL:
			position = Vector2(selected_wall * Constants.wallsize.x, 0)
		CEILING:
			position = Vector2(0, Constants.wallsize.y)
