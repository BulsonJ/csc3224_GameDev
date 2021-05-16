extends Control

var hud = HudVariables

onready var perfDisplay = $Performance
onready var character = get_node("../YSort/Player")
onready var characterDebug = character.get_node("StateLabel")
onready var enemies = get_node("../YSort/Enemies")

func _on_Button_Debug_toggled(button_pressed):
	hud.debug_overlay = button_pressed

func _process(delta):
	
	if hud.debug_overlay == false:
		perfDisplay.hide()
		characterDebug.hide()
		for enemy in enemies.get_children():
			var debug = enemy.get_node("StateLabel")
			debug.hide()
	else:
		perfDisplay.show()
		characterDebug.show()
		for enemy in enemies.get_children():
			var debug = enemy.get_node("StateLabel")
			debug.show()
		

