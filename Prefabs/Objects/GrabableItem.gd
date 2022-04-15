extends GameObject
tool


export(Resource) var item


func _ready():
	if Engine.editor_hint:
		$Sprite.texture = item.texture
		return
	
	assert(item, "No item has been set.")
	item.register()
	$Sprite.texture = item.texture


func _on_GrabableItem_clicked():
	Gamestate.inventory_items.append(item.item_name)
	queue_free()
