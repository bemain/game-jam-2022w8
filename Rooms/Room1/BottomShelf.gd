extends Focusable


func _ready():
	Gamestate.connect("focused_object_changed", self, "on_focused_object_changed")


func on_focused_object_changed():
	if not Gamestate.focused_object:
		for item in $Items.get_children():
			item.get_node("CollisionShape2D").disabled = true


func _on_focused():
	for item in $Items.get_children():
		item.get_node("CollisionShape2D").disabled = false
