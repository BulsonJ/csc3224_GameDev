extends ColorRect

# Reference to the _AnimationPlayer_ node
onready var _anim_player := $AnimationPlayer

func _ready() -> void:
	# Plays the animation backward to fade in
	_anim_player.play_backwards("Fade")

func transition() -> void:
	# Plays the Fade animation and wait until it finishes
	_anim_player.play("Fade")
	yield(_anim_player, "animation_finished")
