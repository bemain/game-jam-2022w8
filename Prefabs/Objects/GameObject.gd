extends Node2D
class_name GameObject


export(String) var object_name = ""


func _ready() -> void:
	assert(object_name, "Object has no name.")
	assert(not object_name in Gamestate.objects, "Duplicate, object already exists: " + object_name)
	
	Gamestate.objects[object_name] = self  # Register item
