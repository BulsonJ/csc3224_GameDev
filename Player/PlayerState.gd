class_name PlayerState
extends State

var player: Player

# Initialise variables
func _ready():
	yield(state_machine, "ready")
	player = state_machine.get_parent() as Player
	assert(player != null)
