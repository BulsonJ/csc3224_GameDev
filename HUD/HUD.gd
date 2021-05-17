extends Control

onready var health_bar = $Scaler/HealthBar
onready var playerStats = PlayerStats

func _ready():
	playerStats.connect("health_changed", self, "_on_Player_health_changed")
	health_bar.value = playerStats.health
	
func _on_Player_health_changed(current_health):
	health_bar.value = current_health
