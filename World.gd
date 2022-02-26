extends Spatial


export(PackedScene) var room_template

onready var room = create_room(room_template)
var Surface3d = preload("res://Surface.tscn")



func create_room(template_packed):
	var template = template_packed.instance()
	var room = Spatial.new()
	room.name = "Room"
	# Generate walls
	for i in range(4):
		# Create wall
		var static_body = create_3d_object(template.get_node("Wall" + str(i + 1)))
		static_body.name = "Wall" + str(i + 1)
		# Position the mesh
		static_body.rotation = Vector3(-PI / 2, i * -PI / 2, 0)
		static_body.translation = Vector3(0, 0, (Constants.wallsize.x / Constants.wallsize.y) / 2).rotated(Vector3(0, 1, 0), i * -PI / 2)
		room.add_child(static_body)
	# Generate ceiling
	var static_body = create_3d_object(template.get_node("Ceiling"), false)
	static_body.name = "Ceiling"
	static_body.rotation = Vector3(PI, 0, 0)
	static_body.translation = Vector3(0, (Constants.wallsize.y / Constants.wallsize.x) / 2, 0)
	room.add_child(static_body)
	# Generate floor
	static_body = create_3d_object(template.get_node("Floor"), false)
	static_body.name = "Floor"
	static_body.translation = Vector3(0, -(Constants.wallsize.y / Constants.wallsize.x) / 2, 0)
	room.add_child(static_body)
	
	add_child(room)
	return room


func create_3d_object(surface, is_wall=true):
	var quad_wall_size = Vector2(Constants.wallsize.x, Constants.wallsize.x)
	# Configure surface
	surface.get_parent().remove_child(surface)
	surface.position = Vector2.ZERO if not surface.centered else (Constants.wallsize / 2 if is_wall else quad_wall_size / 2)
	surface.visible = true
	# Create Surface3d
	var surface3d = Surface3d.instance()
	# Configure viewport
	var viewport = surface3d.get_node("Viewport")
	viewport.size = Constants.wallsize if is_wall else quad_wall_size
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	viewport.physics_object_picking = true
	viewport.add_child(surface)
	# Configure MeshInstnace
	var mesh_instance = surface3d.get_node("MeshInstance")
	mesh_instance.mesh.material.albedo_texture = viewport.get_texture()
	mesh_instance.mesh.size = viewport.size / viewport.size.y
	# Configure CollisionShape
	var collision_shape = surface3d.get_node("CollisionShape")
	collision_shape.shape = mesh_instance.mesh.create_trimesh_shape()
	
	return surface3d
