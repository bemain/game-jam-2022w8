extends Control


export(Array, String) var invContents = []

var hideTimer = -1
var shown :bool = true

onready var animation_player = get_tree().root.get_node("World/AnimationPlayer")


# Called when the node enters the scene tree for the first time.
func _ready():
	Gamestate.connect("inventory_changed", self, "update_inventory")

func _process(delta):
	# Automatically hide inventory
	# Set hideTimer to the time you want to wait before hiding (seconds)
	# Set hideTimer to -1 to disable
	if hideTimer > -1:
		hideTimer -= delta
		if hideTimer <= 0:
			hide()
			hideTimer = -1
			
func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		toggle()


func show():
	animation_player.play_backwards("Toggle Inventory")
	shown = true
	
func hide():
	animation_player.play("Toggle Inventory")
	shown = false

func toggle():
	if shown:
		hide()
	else:
		show()

func update_inventory():
	print("inv update")
	var i = 1
	for v in Gamestate.inventory_items:
		var inv_node = get_node("Inv%s/Item%s" % [i,i])
		var item_texture = Gamestate.items[v].get_node("Sprite").texture
		inv_node.texture = item_texture
		
