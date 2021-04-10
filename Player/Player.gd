extends Node2D
class_name Player


export var ACCELERATION = 16
export var MAX_SPEED = 96
export var ROLL_SPEED = 128
export var FRICTION = 8

var velocity = Vector2.ZERO
var direction = 1




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
