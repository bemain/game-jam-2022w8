extends Spatial
 
var viewports = []


func _ready():
	create_viewports()

func create_viewports():
	var room = $Room
	var surfaces = []
	# Get walls and ceiling
	for i in range(4):
		surfaces.append(room.get_node("Wall" + str(i + 1)))
	surfaces.append(room.get_node("Ceiling"))
	
	# Generate viewports
	for surface in surfaces:
		var viewport = Viewport.new()
		surface.visible = true
		viewport.size = Constants.wallsize
		viewport.add_child(surface)
		viewports.append(viewport)
	remove_child(room)
