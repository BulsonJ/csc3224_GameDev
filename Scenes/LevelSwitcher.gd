extends Node

export var START_ROUND_DURATION = 5
export var END_ROUND_DURATION = 5

export var enemyNode := NodePath()
onready var enemies = get_node(enemyNode)

onready var endRoundTimer = $Timer_EndRound
onready var endRoundScreen = $EndRound_Screen
onready var endRoundCountdown = $EndRound_Screen/Label

onready var startRoundTimer = $Timer_StartRound
onready var startRoundScreen = $StartRound_Screen
onready var startRoundLabel = $StartRound_Screen/Label

onready var _transition_rect := $ScreenTransitionRect
onready var fadeTimer = $Timer_Fade

signal round_start()
signal round_over()

var enemyKilled = 0
	
func _ready():
	endRoundScreen.hide()
	
	startRoundLabel.text = "Round " + str(GameVariables.current_round) + " starting..."
	startRoundScreen.show()
	startRoundTimer.start(START_ROUND_DURATION)
	
	_transition_rect.show()

func _on_Enemy_Killed():
	enemyKilled += 1
	Achievements.enemies_killed += 1
	if enemyKilled == GameVariables.enemy_amount:
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