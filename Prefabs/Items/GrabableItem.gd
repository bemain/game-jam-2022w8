extends Area2D
tool


export(Resource) var item


func _ready():
	if Engine.editor_hint:
		$Sprite.texture = item.texture
		return
	
	assert(item, "No item has been set.")
	item.register()
	$Sprite.texture = item.texture


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		Gamestate.inventory_items.append(item.item_name)
		queue_free()
