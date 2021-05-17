extends MarginContainer

const play_scene = preload("res://Scenes/Main.tscn")

onready var menu_selector = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer
onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_four = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/CenterContainer4/HBoxContainer/Selector

onready var difficulty_select = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/DifficultySelect
onready var difficulty_selector_one = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/DifficultySelect/CenterContainer/HBoxContainer/Selector
onready var difficulty_selector_three = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/DifficultySelect/CenterContainer2/HBoxContainer/Selector
onready var difficulty_selector_four = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/DifficultySelect/CenterContainer3/HBoxContainer/Selector
onready var difficulty_selector_two = $CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/DifficultySelect/CenterContainer4/HBoxContainer/Selector


var current_selection = 0
var current_selection_difficulty = 0

var difficulty_choosing = false

func _ready():
	set_current_selection(0)
	set_current_selection_difficulty(0)
	difficulty_select.hide()
	
func _process(delta):	
	if difficulty_choosing == false:
		if Input.is_action_just_pressed("ui_down") and current_selection < 3:
			current_selection += 1
			set_current_selection(current_selection)
		elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
			current_selection -= 1
			set_current_selection(current_selection)
		elif Input.is_action_just_pressed("ui_accept"):
			handle_selection(current_selection)
	else:
		if Input.is_action_just_pressed("ui_down") and current_selection_difficulty < 3:
			current_selection_difficulty += 1
			set_current_selection_difficulty(current_selection_difficulty)
		elif Input.is_action_just_pressed("ui_up") and current_selection_difficulty > 0:
			current_selection_difficulty -= 1
			set_current_selection_difficulty(current_selection_difficulty)
		elif Input.is_action_just_pressed("ui_accept"):
			handle_selection_difficulty(current_selection_difficulty)
			start_game()
		elif Input.is_action_just_pressed("ui_cancel"):
			difficulty_choosing = false
			difficulty_select.hide()
			menu_selector.modulate = Color(1,1,1)

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	selector_four.text = ""
	
	if _current_selection == 0:
		selector_one.text = ">"
	if _current_selection == 1:
		selector_two.text = ">"
	if _current_selection == 2:
		selector_three.text = ">"
	if _current_selection == 3:
		selector_four.text = ">"
		
func set_current_selection_difficulty(_current_selection):
	difficulty_selector_one.text = ""
	difficulty_selector_two.text = ""
	difficulty_selector_three.text = ""
	difficulty_selector_four.text = ""
	
	if _current_selection == 0:
		difficulty_selector_one.text = ">"
	if _current_selection == 1:
		difficulty_selector_two.text = ">"
	if _current_selection == 2:
		difficulty_selector_three.text = ">"
	if _current_selection == 3:
		difficulty_selector_four.text = ">"
		
func handle_selection(_current_selection):
	if _current_selection == 0:
		difficulty_choosing = true
		difficulty_select.show()
		menu_selector.modulate = Color(0.65,0.65,0.65)
	elif _current_selection == 3:
		get_tree().quit()
		
func handle_selection_difficulty(_current_selection):
	match _current_selection:
		0:
			GameVariables.difficultyChosen = GameVariables.difficultyLevels.Easy
		1:
			GameVariables.difficultyChosen = GameVariables.difficultyLevels.Medium
		2:
			GameVariables.difficultyChosen = GameVariables.difficultyLevels.Hard
		3:
			GameVariables.difficultyChosen = GameVariables.difficultyLevels.Extreme
		
	
func start_game():
	Achievements.reset()
	GameVariables.reset()
	get_tree().change_scene("res://Scenes/Main.tscn")
