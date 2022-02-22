extends Node2D

onready var screensize = get_viewport().size
onready var viewsize = $ViewportContainer/Viewport.size

func _ready():
	var scale_val = min(screensize.x / viewsize.x, screensize.y / viewsize.y)
	$ViewportContainer.rect_scale = Vector2(scale_val, scale_val)
	$ViewportContainer.rect_position = screensize / 2 - scale_val * viewsize / 2

