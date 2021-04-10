extends Node

class_name StateMachine

signal state_changed(new_state)

export var initialState := NodePath()
onready var currentState = get_node(initialState)

func _ready():
	yield(owner, "ready")
	for child in get_children():
		child.set_physics_process(false)
		child.set_process(false)
	currentState.enter()
	currentState.set_physics_process(true)
	currentState.set_process(true)
		
func changeState(new_state_target: String):
	if not has_node(new_state_target):
		return
		
	var newState = get_node(new_state_target)
		
	# If the new state is not the same as the current ( Stops repeatedly entering same state)
	if newState != currentState:
		# exit current state
		currentState.exit()
		currentState.set_physics_process(false)
		currentState.set_process(false)
		
		# enter new state
		currentState = newState
		currentState.enter()
		currentState.set_physics_process(true)
		currentState.set_process(true)
		emit_signal("state_changed", currentState)
