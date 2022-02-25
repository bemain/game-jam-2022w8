extends Spatial


onready var room = create_room()


func _ready():
	set_process_input(true)

func _input(event):
	for surface in room.get_children():
		surface.get_node("Viewport").unhandled_input(event)

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
	surface.get_parent().remove_child(surface)
	surface.position = Constants.wallsize / 2 if surface.centered else Vector2.ZERO
	surface.visible = true
	# Create viewport
	var viewport = Viewport.new()
	viewport.name = "Viewport"
	viewport.size = Constants.wallsize
	viewport.set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	viewport.physics_object_picking = true
	viewport.add_child(surface)
	# Create mesh
	var mesh_instance = MeshInstance.new()
	var plane_mesh = PlaneMesh.new()
	var material = SpatialMaterial.new()
	material.albedo_texture = viewport.get_texture()
	plane_mesh.size = viewport.size / viewport.size.x
	plane_mesh.material = material
	mesh_instance.name = "MeshInstance"
	mesh_instance.mesh = plane_mesh
	# Create StaticBody
	var static_body = StaticBody.new()
	var collision_shape = CollisionShape.new()
	collision_shape.name = "CollisionShape"
	collision_shape.shape = plane_mesh.create_trimesh_shape()
	static_body.add_child(collision_shape)
	static_body.add_child(viewport)
	static_body.add_child(mesh_instance)
	
	return static_body
