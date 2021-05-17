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
	animationTree.active = true

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(1)
	hurtbox.create_hit_effect()
	$Sound_Hurt.play()

func _on_StateMachine_state_changed(new_state):
	$StateLabel.text=new_state.get_name()
	
func _physics_process(delta):
	if velocity != Vector2.ZERO and $StateMachine.currentState != get_node("StateMachine/Idle") and $StateMachine.currentState != get_node("StateMachine/Attack"):
		if $Sound_Move.playing == false:
			$Sound_Move.play()
