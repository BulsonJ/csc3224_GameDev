extends PlayerState

func enter():
	if player.direction < 0:
		player.animationPlayer.play("run_left")
	else:
		player.animationPlayer.play("run_right")

# Runs process
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
			
	if input_vector != Vector2.ZERO:
		player.roll_vector = input_vector
		
		# If input x is not 0, check if direction changed
		if input_vector.x != 0:
			player.direction = input_vector.x
			
			if player.direction < 0:
				player.animationPlayer.play("run_left")
			else:
				player.animationPlayer.play("run_right")

		
		player.velocity = player.velocity.move_toward(input_vector * player.MAX_SPEED, player.ACCELERATION * delta)
	
	if input_vector == Vector2.ZERO:
		state_machine.changeState("Idle")	
	if Input.is_action_just_pressed("attack"):
		state_machine.changeState("Attack")
	if Input.is_action_just_pressed("dash"):
		state_machine.changeState("Dash")
	
	player.velocity = player.move_and_slide(player.velocity)
	
