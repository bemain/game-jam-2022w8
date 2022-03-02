extends Node


signal current_day_changed
signal inventory_changed
signal focused_object_changed


export(int) var current_day = 0 setget set_current_day

export(Dictionary) var items
export(Array, String) var inventory_items
export(String) var selected_item

export(Dictionary) var objects
export(String) var focused_object setget set_focused_object


func set_current_day(value):
	current_day = value
	emit_signal("current_day_changed", value)

func add_to_inventory(value):
	inventory_items.append(value)
	emit_signal("inventory_changed")

func set_focused_object(value):
	focused_object = value
	emit_signal("focused_object_changed")
