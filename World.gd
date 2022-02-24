extends Node2D

func _ready():
	var scale_val = min(Constants.screensize.x / Constants.viewsize.x, Constants.screensize.y / Constants.viewsize.y)
	$ViewportContainer.rect_scale = Vector2(scale_val, scale_val)
	$ViewportContainer.rect_position = Constants.screensize / 2 - scale_val * Constants.viewsize / 2

