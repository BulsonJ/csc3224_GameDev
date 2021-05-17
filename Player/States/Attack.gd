extends PlayerState

func enter():
	if player.direction < 0:
		player.animationPlayer.play("attack_left")
	else:
		player.animationPlayer.play("attack_right")
	$Sound_Attack.play()
	
func _physics_process(delta):
	player.velocity = player.velocity.move_toward(Vector2.ZERO * player.MAX_SPEED, player.FRICTION * delta)
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)

func attack_animation_finished():
	state_machine.changeState("Idle")
