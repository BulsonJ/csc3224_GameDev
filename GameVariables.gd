extends Node

export var INITIAL_ENEMIES = 5
export var ENEMY_INCREASE = 4
export var ENEMY_SPAWN_TIMER = 2

onready var MASTER_VOLUME = 100 setget set_volume_master
onready var SOUND_EFFECT_VOLUME = 100 setget set_volume_effects
onready var MUSIC_VOLUME = 100 setget set_volume_music

onready var enemy_amount = INITIAL_ENEMIES

var cheat_GodMode = false

var current_round = 1

enum difficultyLevels{
	Easy,
	Medium,
	Hard,
	Extreme
}

var difficultyChosen = difficultyLevels.Easy setget set_difficulty

func set_difficulty(difficulty):
	difficultyChosen = difficulty
	match difficultyChosen:
		difficultyLevels.Easy:
			INITIAL_ENEMIES = 5
			ENEMY_INCREASE = 4
			ENEMY_SPAWN_TIMER = 2
		difficultyLevels.Medium:
			INITIAL_ENEMIES = 7
			ENEMY_INCREASE = 5
			ENEMY_SPAWN_TIMER = 1.5
		difficultyLevels.Hard:
			INITIAL_ENEMIES = 10
			ENEMY_INCREASE = 6
			ENEMY_SPAWN_TIMER = 1
		difficultyLevels.Extreme:
			INITIAL_ENEMIES = 14
			ENEMY_INCREASE = 8
			ENEMY_SPAWN_TIMER = 0.5

func set_volume_master(volume):
	MASTER_VOLUME = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(MASTER_VOLUME/100.0))

func set_volume_effects(volume):
	SOUND_EFFECT_VOLUME = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), linear2db(SOUND_EFFECT_VOLUME/100.0))
	
func set_volume_music(volume):
	MUSIC_VOLUME = volume
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(MUSIC_VOLUME/100.0))
	

func reset():
	current_round = 1
	enemy_amount = INITIAL_ENEMIES
