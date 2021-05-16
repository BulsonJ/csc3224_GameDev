extends PlayerState

func enter():
	player.animationState.travel("Attack")
	
func _physics_process(delta):
	player.velocity = player.velocity.move_toward(Vector2.ZERO * player.MAX_SPEED, player.FRICTION * delta)
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func attack_animation_finished():
	state_machine.changeState("Idle")
