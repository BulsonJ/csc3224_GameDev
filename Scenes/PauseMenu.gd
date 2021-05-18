extends CanvasLayer

onready var selector_one = $PauseMenu/PanelContainer/VBoxContainer/Button_Continue/Selector
onready var selector_two = $PauseMenu/PanelContainer/VBoxContainer/Button_Quit/Selector

onready var pause_menu = $PauseMenu

var current_selection = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	
	if get_tree().current_scene.name == "Main":
		if event.is_action_pressed("ui_cancel"):
			$Background.visible = !$Background.visible
			get_tree().paused = !get_tree().paused
			if pause_menu.visible == true:
				pause_menu.hide()
			else:
				pause_menu.show()
			
		
		if get_tree().paused == true:
			if event.is_action_pressed("ui_down") and current_selection < 1:
				current_selection += 1
				set_current_selection(current_selection)
			elif event.is_action_pressed("ui_up") and current_selection > 0:
				current_selection -= 1
				set_current_selection(current_selection)
			elif event.is_action_pressed("ui_accept"):
				handle_selection(current_selection)

		
		
func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	if _current_selection == 1:
		selector_two.text = ">"

func handle_selection(_current_selection):
	if _current_selection == 0:
		$Background.visible = !$Background.visible
		get_tree().paused = !get_tree().paused
		if pause_menu.visible == true:
				pause_menu.hide()
		else:
			pause_menu.show()
	elif _current_selection == 1:
		$Background.visible = !$Background.visible
		get_tree().paused = !get_tree().paused
		if pause_menu.visible == true:
			pause_menu.hide()
		else:
			pause_menu.show()
		get_tree().change_scene("res://Scenes/MainMenu.tscn")

		
