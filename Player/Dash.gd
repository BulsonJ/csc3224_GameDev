extends PlayerState

func enter():
	if player.direction < 0:
		player.animationPlayer.play("dash_left")
	else:
		player.animationPlayer.play("dash_right")
	$Sound_Dash.play()
	
func _physics_process(delta):
	player.velocity = player.roll_vector * player.ROLL_SPEED
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)		
	
func dash_animation_finished():
	player.velocity = player.velocity * 0.8
	state_machine.changeState("Idle")


