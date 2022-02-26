extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hideTimer = -1
var shown :bool = true

export(Array, String) var invContents = []


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

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
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		print("key", event.scancode)
		if event.scancode == KEY_I:
			print("i")
			toggle()

func show():
	get_node("InventoryAnimator").play_backwards("in-out")
	shown = true
	
func hide():
	get_node("InventoryAnimator").play("in-out")
	shown = false

func toggle():
	if shown:
		hide()
	else:
		show()
