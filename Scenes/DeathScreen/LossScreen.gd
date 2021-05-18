extends MarginContainer

const play_scene = preload("res://Scenes/Main.tscn")

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector

onready var enemiesKilledLabel = $CenterContainer/VBoxContainer/VBoxContainer/CenterContainer3/Label
onready var roundLabel = $CenterContainer/VBoxContainer/VBoxContainer/CenterContainer4/Label
onready var difficultyLabel = $CenterContainer/VBoxContainer/VBoxContainer/CenterContainer5/Label
var current_selection = 0

func _ready():
	set_current_selection(0)
	enemiesKilledLabel.text = "Enemies Slain: " + str(Achievements.enemies_killed)
	roundLabel.text = "Round: " + str(Achievements.round_achieved)
	difficultyLabel.text = "Difficulty: " + GameVariables.difficultyLevels.keys()[GameVariables.difficultyChosen]
	
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 1:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
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
		Achievements.reset()
		GameVariables.reset()
		PlayerStats.health = 100
		get_tree().change_scene("res://Scenes/Main.tscn")
	elif _current_selection == 1:
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
