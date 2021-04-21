extends PlayerState

func enter():
	player.animationState.travel("Move")

# Runs process
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
			
	if input_vector != Vector2.ZERO:
		player.animationTree.set("parameters/Idle/blend_position", input_vector.x)
		player.animationTree.set("parameters/Move/blend_position", input_vector.x)
		player.animationTree.set("parameters/Attack/blend_position", input_vector.x)
		player.velocity = player.velocity.move_toward(input_vector * player.MAX_SPEED, player.ACCELERATION * delta)
	
	if input_vector == Vector2.ZERO:
		state_machine.changeState("Idle")	
	if Input.is_action_just_pressed("attack"):
		state_machine.changeState("Attack")
	
	player.velocity = player.move_and_slide(player.velocity)
	
