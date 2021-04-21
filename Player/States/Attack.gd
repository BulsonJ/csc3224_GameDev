extends PlayerState

func enter():
	player.animationState.travel("Attack")
	
func _physics_process(delta):
	player.velocity = player.velocity.move_toward(Vector2.ZERO * player.MAX_SPEED, player.FRICTION * delta)

func attack_animation_finished():
	state_machine.changeState("Idle")
