extends Node2D
class_name Player

export var ACCELERATION = 16
export var MAX_SPEED = 96
export var ROLL_SPEED = 128
export var FRICTION = 8

var velocity = Vector2.ZERO
var direction = 1

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_StateMachine_state_changed(new_state):
	$StateLabel.text=new_state.get_name()
