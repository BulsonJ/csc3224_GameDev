extends Node2D
class_name Player

export var ACCELERATION = 16
export var MAX_SPEED = 96
export var ROLL_SPEED = 128
export var FRICTION = 8

var velocity = Vector2.ZERO
var direction = 1

var stats = PlayerStats

onready var hurtbox = $Hurtbox

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	stats.connect("no_health", self, "queue_free")

func _on_Hurtbox_area_entered(_area):
	stats.health -= 1
	$Sprite.modulate = Color(1,0,0)
	hurtbox.start_invincibility(1)
	hurtbox.create_hit_effect()

func _on_StateMachine_state_changed(new_state):
	$StateLabel.text=new_state.get_name()
