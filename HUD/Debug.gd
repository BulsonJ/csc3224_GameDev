extends Control

var hud = HudVariables

onready var perfDisplay = $Performance
#onready var character = get_node("../YSort/Player")
#onready var characterDebug = character.get_node("StateLabel")
onready var enemies = get_node("../YSort/Walls")

func _on_Button_Debug_toggled(button_pressed):
	hud.debug_overlay = button_pressed

func _input(event):
	if event.is_action_pressed("debug_show") && hud.debug_overlay == false:
		hud.debug_overlay = true
		$Button_Debug.pressed = true
	elif event.is_action_pressed("debug_show") && hud.debug_overlay == true:
		hud.debug_overlay = false
		$Button_Debug.pressed = false

func _process(delta):
	
	if hud.debug_overlay == false:
		perfDisplay.hide()
#		characterDebug.hide()
		for enemy in enemies.get_children():
			var debug = enemy.get_node("StateLabel")
			if debug != null:
				debug.hide()
	else:
		perfDisplay.show()
#		characterDebug.show()
		for enemy in enemies.get_children():
			var debug = enemy.get_node("StateLabel")
			if debug != null:
				debug.show()
		
		var objectCounter = 0;
#		if character != null:
#			objectCounter += 1
		for enemy in enemies.get_children():
			objectCounter += 1
		$Performance/Objects_Label.text = "Objects: " + str(objectCounter)
