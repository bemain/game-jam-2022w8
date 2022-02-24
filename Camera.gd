extends Camera2D

enum {WALL, CEILING}


onready var ceiling = get_node("../Room").get_node("Ceiling")
var walls = []

var selected_wall = 0 setget set_selected_wall
var selected_type = WALL

func set_selected_wall(value):
	selected_wall = fposmod(value, 4)


func _ready():
	# Get walls
	for i in range(4):
		walls.append(get_node("../Room").get_node("Wall" + str(i + 1)))

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

func _process(delta):
	# If moving, apply perspective to the walls
	if (position - get_camera_screen_center()).length() > 10:
		apply_perspective()


func move(direction: Vector2):
	# Move
	var target_pos = position + Constants.wallsize * direction
	position = target_pos
	# Set position of wall / ceiling
	if direction.x:
		self.selected_wall += direction.x
		walls[selected_wall].position.x = target_pos.x
	if direction.y:
		ceiling.position.x = target_pos.x
		ceiling.rotation = selected_wall * PI / 2
	

func apply_perspective():
	# Walls
	for wall in walls:
		var rel_pos = (get_camera_screen_center() - wall.position) / Constants.wallsize
		if -2 < rel_pos.x and rel_pos.x < 2:
			wall.material.set_shader_param("position", rel_pos)
	
	# Ceiling
	var rel_pos = (get_camera_screen_center() - ceiling.position) / Constants.wallsize
	ceiling.material.set_shader_param("position", rel_pos.rotated(-ceiling.rotation))
