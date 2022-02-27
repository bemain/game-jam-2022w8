extends Lock


onready var animated_sprite = $AnimatedSprite


func _ready():
	animated_sprite.animation = "Locked"


func _on_unlocked():
	animated_sprite.animation = "Unlocked"
