extends Spatial


onready var room = create_room()
var Surface3d = preload("res://Surface.tscn")



func create_room():
	var room2d = $Room
	var room3d = Spatial.new()
	room3d.name = "Room"
	# Generate walls
	for i in range(4):
		var static_body = create_3d_object(room2d.get_node("Wall" + str(i + 1)))
		static_body.name = "Wall" + str(i + 1)
		# Position the mesh
		static_body.rotate(Vector3(1, 0, 0), -PI / 2)
		static_body.rotate(Vector3(0, 1, 0), i * PI / 2)
		static_body.translation = Vector3(0, 0, 0.5).rotated(Vector3(0, 1, 0), i * PI / 2)
		room3d.add_child(static_body)
	# Generate ceilings
	var static_body = create_3d_object(room2d.get_node("Ceiling"))
	static_body.name = "Ceiling"
	# Position the mesh
	static_body.rotate(Vector3(1, 0, 0), PI)
	static_body.translation = Vector3(0, 0.5, 0)
	room3d.add_child(static_body)
	
	remove_child(room2d)
	
	add_child(room3d)
	return room3d


func create_3d_object(surface):
	# Configure surface
	surface.get_parent().remove_child(surface)
	surface.position = Constants.wallsize / 2 if surface.centered else Vector2.ZERO
	surface.visible = true
	# Create Surface3d
	var surface3d = Surface3d.instance()
	# Configure viewport
	var viewport = surface3d.get_node("Viewport")
	viewport.size = Constants.wallsize
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
