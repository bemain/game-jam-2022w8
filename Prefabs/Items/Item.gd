extends Resource 
class_name Item


export(String) var item_name = ""
export(Texture) var texture

var _is_registered = false


func register():
	if _is_registered:
		return
	_is_registered = true
	
	assert(item_name, "Item has no name.")
	assert(not item_name in Gamestate.items, "Duplicate, item already exists: " + item_name)
	
	assert(texture, "Item has no texture")
	
	Gamestate.items[item_name] = self  # Register item
