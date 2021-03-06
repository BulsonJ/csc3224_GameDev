extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 30
export var FRICTION = 20
export var WANDER_TARGET_RANGE = 4

export (float) var ATTACK_COOLDOWN = 1

var knockback = Vector2.ZERO
var velocity = Vector2.ZERO

signal state_changed(new_state)
signal enemy_killed()

onready var hurtbox = $Hurtbox
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var attackDetectionZone = $AttackDetectionZone
onready var hitbox = $HitboxPivot/Hitbox/CollisionShape2D
onready var attackTimer = $AttackTimer
onready var wanderController = $WanderController
onready var softCollision = $SoftCollision

export (PackedScene) var DeathEffect

var cooldown = false

var direction = 0

enum state{
	Idle,
	Wander,
	Chase,
	Attack
}

var currentState = state.Idle

func _ready():
	hitbox.disabled = true
	currentState = pick_random_state([state.Idle, state.Wander])
	emit_signal("state_changed", currentState)

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
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
				
		state.Wander:
			direction = velocity.x
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
				
				accelerate_towards_point(wanderController.target_position, delta)
				
				if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
					update_wander()
					
		state.Chase:
			direction = velocity.x
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				currentState = state.Idle
				
			sprite.play("Run")
			sprite.flip_h = velocity.x < 0
			if velocity.x < 0:
				$HitboxPivot.scale = Vector2(-1, 1)
			else:
				$HitboxPivot.scale = Vector2(1, 1)
				
			if cooldown == false:
				attack_player()
			
		state.Attack:
			velocity = velocity.move_toward(Vector2.ZERO * MAX_SPEED, FRICTION * delta)
			if sprite.frame == 3:
				$Sound_Attack.play()
			if sprite.frame == 6 or sprite.frame == 7:
				hitbox.disabled = false
			
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 300
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				
	sprite.play("Run")
	sprite.flip_h = velocity.x < 0
	if velocity.x < 0:
		$HitboxPivot.scale = Vector2(-1, 1)
	else:
		$HitboxPivot.scale = Vector2(1, 1)

func update_wander():
	currentState = pick_random_state([state.Idle, state.Wander])
	emit_signal("state_changed", currentState)
	wanderController.start_wander_timer(rand_range(1,3))

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 30
	hurtbox.create_hit_effect()

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = DeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	if direction < 0:
		enemyDeathEffect.scale = Vector2(-1, 1)
	else:
		enemyDeathEffect.scale = Vector2(1, 1)
	emit_signal("enemy_killed")

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func seek_player():
	if playerDetectionZone.can_see_player():
		currentState = state.Chase
		emit_signal("state_changed", currentState)
		
func attack_player():
	if attackDetectionZone.can_see_player():
		currentState = state.Attack
		emit_signal("state_changed", currentState)
		sprite.play("Attack")

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
