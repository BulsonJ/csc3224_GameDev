extends Node

class_name State

# FSM assigns itself
onready var state_machine = get_parent()

# Initialise variables
func _ready():
	pass

# Runs when state is entered
func enter():
	pass
	
# Runs process
func _process(_delta):
	pass
	
# Runs process
func _physics_process(_delta):
	pass
	
func exit():
	pass
