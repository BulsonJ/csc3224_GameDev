extends PlayerState

func enter():
	if player.direction < 0:
		player.animationPlayer.play("idle_left")
	else:
		player.animationPlayer.play("idle_right")

# Runs process
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
		
	player.velocity = player.velocity.move_toward(Vector2.ZERO * player.MAX_SPEED, player.FRICTION * delta)
	
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	if input_vector != Vector2.ZERO:
		player.direction = input_vector.x
		state_machine.changeState("Move")
	if Input.is_action_just_pressed("attack"):
		state_machine.changeState("Attack")
