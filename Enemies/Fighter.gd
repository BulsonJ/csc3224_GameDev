extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 30
export var FRICTION = 20

export var ATTACK_COOLDOWN = 1

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

signal state_changed(new_state)

onready var hurtbox = $Hurtbox
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hitbox = $HitboxPivot/Hitbox/CollisionShape2D
onready var attackTimer = $AttackTimer

const Fighter_DeathEffect = preload("res://Enemies/Fighter_DeathEffect.tscn")

var playerInRange = false
var cooldown = false

enum state{
	Idle,
	Wander,
	Chase
	Attack
}

var currentState = state.Idle


func _ready():
	hitbox.disabled = true

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match currentState:
		state.Idle:
			velocity = velocity.move_toward(Vector2.ZERO * MAX_SPEED, FRICTION * delta)
			if velocity == Vector2.ZERO:
				sprite.play("Idle")
			else:
				sprite.play("Run")
		state.Wander:
			pass
		state.Chase:
			var player = playerDetectionZone.player
			if player != null:
				var direction =  global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				
			sprite.play("Run")
			sprite.flip_h = velocity.x < 0
			if velocity.x < 0:
				$HitboxPivot.scale = Vector2(-1, 1)
			else:
				$HitboxPivot.scale = Vector2(1, 1)
				
			if playerInRange && cooldown == false:
				currentState = state.Attack
				emit_signal("state_changed", currentState)
		state.Attack:
			cooldown == true
			velocity = velocity.move_toward(Vector2.ZERO * MAX_SPEED, FRICTION * delta)
			sprite.play("Attack")
			if sprite.frame == 6 or sprite.frame == 7:
				hitbox.disabled = false
			
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 60
	hurtbox.create_hit_effect()

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = Fighter_DeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_PlayerDetectionZone_body_entered(_body):
	currentState = state.Chase
	emit_signal("state_changed", currentState)

func _on_PlayerDetectionZone_body_exited(_body):
	currentState = state.Idle
	emit_signal("state_changed", currentState)

func _on_AttackDetectionZone_body_entered(body):
	playerInRange = true

func _on_AttackDetectionZone_body_exited(body):
	playerInRange = false

func _on_AnimatedSprite_animation_finished():
	if sprite.get_animation() == "Attack":
		currentState = state.Chase
		attackTimer.start(ATTACK_COOLDOWN)
		cooldown = true
		hitbox.disabled = true
		emit_signal("state_changed", currentState)

func _on_Enemy_1_state_changed(new_state):
	$StateLabel.text=state.keys()[new_state]

func _on_AttackTimer_timeout():
	cooldown = false
