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

onready var option_menu = $OptionsMenu
onready var option_selector_one = $OptionsMenu/PanelContainer/VBoxContainer/MasterVolume/Selector
onready var option_selector_two = $OptionsMenu/PanelContainer/VBoxContainer/SoundEffectVolume/Selector
onready var option_selector_three = $OptionsMenu/PanelContainer/VBoxContainer/MusicVolume/Selector
onready var option_volume_selector_one = $OptionsMenu/PanelContainer/VBoxContainer/MasterVolume/Volume
onready var option_volume_selector_two = $OptionsMenu/PanelContainer/VBoxContainer/SoundEffectVolume/Volume
onready var option_volume_selector_three = $OptionsMenu/PanelContainer/VBoxContainer/MusicVolume/Volume

onready var help_menu = $HelpMenu
onready var help_menu_open = false

var current_selection = 0
var current_selection_difficulty = 0
var current_selection_option = 0

var difficulty_choosing = false
var option_menu_open = false

func _ready():
	set_current_selection(0)
	set_current_selection_difficulty(0)
	difficulty_select.hide()
	
	handle_selection_options(0, 0)
	handle_selection_options(1, 0)
	handle_selection_options(2, 0)
	
func _input(event):
	if difficulty_choosing == false and option_menu_open == false and help_menu_open == false:
		if event.is_action_pressed("ui_down") and current_selection < 3:
			current_selection += 1
			set_current_selection(current_selection)
		elif event.is_action_pressed("ui_up") and current_selection > 0:
			current_selection -= 1
			set_current_selection(current_selection)
		elif event.is_action_pressed("ui_accept"):
			handle_selection(current_selection)
	elif option_menu_open == true:
		if event.is_action_pressed("ui_down") and current_selection_option < 2:
			current_selection_option += 1
			set_current_selection_options(current_selection_option)
		elif event.is_action_pressed("ui_up") and current_selection_option > 0:
			current_selection_option -= 1
			set_current_selection_options(current_selection_option)
		elif event.is_action_pressed("ui_left", true):
			handle_selection_options(current_selection_option, -5)
		elif event.is_action_pressed("ui_right", true):
			handle_selection_options(current_selection_option, 5)
		elif event.is_action_pressed("ui_cancel"):
			option_menu_open = false
			option_menu.hide()
	elif help_menu_open == true:
		if event is InputEventKey:
			if event.pressed:
				help_menu_open = false
				help_menu.hide()
	else:
		if event.is_action_pressed("ui_down") and current_selection_difficulty < 3:
			current_selection_difficulty += 1
			set_current_selection_difficulty(current_selection_difficulty)
		elif event.is_action_pressed("ui_up") and current_selection_difficulty > 0:
			current_selection_difficulty -= 1
			set_current_selection_difficulty(current_selection_difficulty)
		elif event.is_action_pressed("ui_accept"):
			handle_selection_difficulty(current_selection_difficulty)
			start_game()
		elif event.is_action_pressed("ui_cancel"):
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
		
func set_current_selection_options(_current_selection):
	option_selector_one.text = ""
	option_selector_two.text = ""
	option_selector_three.text = ""
	
	if _current_selection == 0:
		option_selector_one.text = ">"
	if _current_selection == 1:
		option_selector_two.text = ">"
	if _current_selection == 2:
		option_selector_three.text = ">"
		
func handle_selection(_current_selection):
	if _current_selection == 0:
		difficulty_choosing = true
		difficulty_select.show()
		menu_selector.modulate = Color(0.65,0.65,0.65)
	elif _current_selection == 1:
		help_menu_open = true
		help_menu.show()
	elif _current_selection == 2:
		option_menu_open = true
		option_menu.show()
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
			
func handle_selection_options(_current_selection, change):
	match _current_selection:
		0:
			GameVariables.MASTER_VOLUME = handle_change_volume(GameVariables.MASTER_VOLUME, change)
			if GameVariables.MASTER_VOLUME <= 0:
				option_volume_selector_one.text = "  " + str(GameVariables.MASTER_VOLUME) + " >"
			elif GameVariables.MASTER_VOLUME >= 100:
				option_volume_selector_one.text = "< " + str(GameVariables.MASTER_VOLUME) + " "
			else:
				option_volume_selector_one.text = "< " + str(GameVariables.MASTER_VOLUME) + " >"
		1:
			GameVariables.SOUND_EFFECT_VOLUME = handle_change_volume(GameVariables.SOUND_EFFECT_VOLUME, change)
			if GameVariables.SOUND_EFFECT_VOLUME <= 0:
				option_volume_selector_two.text = "  " + str(GameVariables.SOUND_EFFECT_VOLUME) + " >"
			elif GameVariables.SOUND_EFFECT_VOLUME >= 100:
				option_volume_selector_two.text = "< " + str(GameVariables.SOUND_EFFECT_VOLUME) + " "
			else:
				option_volume_selector_two.text = "< " + str(GameVariables.SOUND_EFFECT_VOLUME) + " >"
		2:
			GameVariables.MUSIC_VOLUME = handle_change_volume(GameVariables.MUSIC_VOLUME, change)
			if GameVariables.MUSIC_VOLUME <= 0:
				option_volume_selector_three.text = "  " + str(GameVariables.MUSIC_VOLUME) + " >"
			elif GameVariables.MUSIC_VOLUME >= 100:
				option_volume_selector_three.text = "< " + str(GameVariables.MUSIC_VOLUME) + " "
			else:
				option_volume_selector_three.text = "< " + str(GameVariables.MUSIC_VOLUME) + " >"

func handle_change_volume(_volume_option, change):
	if _volume_option + change < 0:
		return 0
	elif _volume_option + change > 100:
		return 100
	else:
		return _volume_option + change
	
func start_game():
	Achievements.reset()
	GameVariables.reset()
	get_tree().change_scene("res://Scenes/Main.tscn")
