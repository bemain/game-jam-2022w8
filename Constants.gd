extends Node


const wallsize = Vector2(1024, 1024)
onready var screensize = get_viewport().size
onready var viewsize = get_tree().root.get_node("World/ViewportContainer/Viewport").size
