extends Control

var hud = HudVariables

onready var perfDisplay = $Performance
onready var character = get_node("../World/YSort/Player")
onready var characterDebug = character.get_node("StateLabel")
onready var enemies = get_node("../World/YSort/Walls")
onready var health_label = get_node("../HUD/HealthBar/Label")
onready var cheat_buttons = $Cheat_Buttons

onready var levelSwitch = get_node("../LevelSwitcher")

var characterDead = false

func _on_Button_Debug_toggled(button_pressed):
	hud.debug_overlay = button_pressed

func _input(event):
	if event.is_action_pressed("debug_show") && hud.debug_overlay == false:
		hud.debug_overlay = true
		$Button_Debug.pressed = true
	elif event.is_action_pressed("debug_show") && hud.debug_overlay == true:
		hud.debug_overlay = false
		$Button_Debug.pressed = false
	
	if event.is_action_pressed("godmode") && GameVariables.cheat_GodMode == false:
		GameVariables.cheat_GodMode = true
		$Cheat_Buttons/Button_GodMode.pressed = true
	elif event.is_action_pressed("godmode") && GameVariables.cheat_GodMode == true:
		GameVariables.cheat_GodMode = false
		$Cheat_Buttons/Button_GodMode.pressed = false
		
	if event.is_action_pressed("plusRound"):
		levelSwitch.end_round()
		$Cheat_Buttons/Button_GodMode.pressed = true

func _process(delta):
	
	if hud.debug_overlay == false:
		perfDisplay.hide()
		health_label.hide()
		cheat_buttons.hide()
		if characterDead == false:
			characterDebug.hide()
		for enemy in enemies.get_children():
			if enemy != null:
				var debug = enemy.get_node("StateLabel")
				if debug != null:
					debug.hide()
	else:
		perfDisplay.show()
		health_label.show()
		cheat_buttons.show()
		if characterDead == false:
			characterDebug.show()
		for enemy in enemies.get_children():
			if enemy != null:
				var debug = enemy.get_node("StateLabel")
				if debug != null:
					debug.show()
		
		var objectCounter = 0;
		if characterDead == false:
			objectCounter += 1
		for enemy in enemies.get_children():
			objectCounter += 1
		$Performance/Objects_Label.text = "Objects: " + str(objectCounter)

func _on_Player_player_dead():
	characterDead = true


func _on_Button_GodMode_toggled(button_pressed):
	GameVariables.cheat_GodMode = button_pressed


func _on_Button_PlusRound_toggled(button_pressed):
	if button_pressed == true:
		levelSwitch.end_round()
