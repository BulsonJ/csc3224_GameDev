extends Control

onready var health_bar = $HealthBar/HealthBar
onready var playerStats = PlayerStats
onready var debugLabel = $HealthBar/Label

onready var enemiesLabel = $Enemies_Killed/Label

func _ready():
	playerStats.connect("health_changed", self, "_on_Player_health_changed")
	health_bar.value = playerStats.health
	debugLabel.text = str(playerStats.health)
	
func _on_Player_health_changed(current_health):
	health_bar.value = current_health
	debugLabel.text = str(current_health)

func _process(delta):
	enemiesLabel.text = str(Achievements.enemies_killed)


func _on_Player_player_dead():
	pass # Replace with function body.
