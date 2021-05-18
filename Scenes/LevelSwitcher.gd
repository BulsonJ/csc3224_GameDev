extends Node

export var START_ROUND_DURATION = 5
export var END_ROUND_DURATION = 5
export var DEATH_DURATION = 5

export var enemyNode := NodePath()
onready var enemies = get_node(enemyNode)

onready var endRoundTimer = $Timer_EndRound
onready var endRoundScreen = $EndRound_Screen
onready var endRoundCountdown = $EndRound_Screen/Label

onready var startRoundTimer = $Timer_StartRound
onready var startRoundScreen = $StartRound_Screen
onready var startRoundLabel = $StartRound_Screen/Label

onready var deathTimer = $Timer_Loss

onready var _transition_rect := $ScreenTransitionRect
onready var fadeTimer = $Timer_Fade

var rng = RandomNumberGenerator.new()
export (Array, NodePath) var arenas = []

signal round_start()
signal round_over()
signal game_over()

var enemyKilled = 0
	
func _ready():
	endRoundScreen.hide()
	
	startRoundLabel.text = "Round " + str(GameVariables.current_round) + " starting..."
	startRoundScreen.show()
	startRoundTimer.start(START_ROUND_DURATION)
	
	rng.randomize()
	var arena = rng.randi_range(0, arenas.size())
	if arena != 0:
		get_node(arenas[arena - 1]).show()
		for i in arenas:
			if i != arenas[arena-1]:
				get_node(i).queue_free()
	else:
		for i in arenas:
			get_node(i).queue_free()
	
	if GameVariables.difficultyChosen != GameVariables.difficultyLevels.Extreme:
		PlayerStats.health = 100
	GameVariables.cheat_GodMode = false
	
	_transition_rect.show()

func _on_Enemy_Killed():
	enemyKilled += 1
	Achievements.enemies_killed += 1
	if enemyKilled == GameVariables.enemy_amount:
		end_round()
		
func end_round():
	emit_signal("round_over")
	endRoundTimer.start(END_ROUND_DURATION)
	fadeTimer.start(END_ROUND_DURATION - 1)
	endRoundScreen.show()

func _on_Spawner_enemy_spawned():
	var enemyObject = enemies.get_child(enemies.get_child_count() - 1)
	enemyObject.connect("enemy_killed", self, "_on_Enemy_Killed")

func _on_Timer_EndRound_timeout():
	#add enemies for next round
	GameVariables.enemy_amount += GameVariables.ENEMY_INCREASE
	GameVariables.current_round += 1
	Achievements.round_achieved += 1
	get_tree().change_scene("res://Scenes/Main.tscn")

func _on_Timer_StartRound_timeout():
	emit_signal("round_start")
	startRoundScreen.hide()

func _on_Timer_Fade_timeout():
	_transition_rect.transition()

func _on_Player_player_dead():
	emit_signal("game_over")
	$Loss_Sound.play()
	$Loss_Text.show()
	fadeTimer.start(DEATH_DURATION-1)
	deathTimer.start(DEATH_DURATION)
	
func _on_Timer_Loss_timeout():
	get_tree().change_scene("res://Scenes/DeathScreen/LossScreen.tscn")
