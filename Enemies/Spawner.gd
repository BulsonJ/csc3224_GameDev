extends Node

export (PackedScene) var ENEMY_OBJECT
export var spawnNode := NodePath()


onready var SPAWN_TIME = GameVariables.ENEMY_SPAWN_TIMER
onready var NUMBER_OF_ENEMIES = GameVariables.enemy_amount

onready var spawnPoints = $SpawnPoints
onready var timer = $Timer

var rng = RandomNumberGenerator.new() 
var enemiesSpawned = 0
var freeSpawnPoint = false
var spawnEnemy = true

signal enemy_spawned()

func spawn(spawnPoint):
	var enemy_instance = ENEMY_OBJECT.instance()
	enemy_instance.set_name("Fighter")
	enemy_instance.position = spawnPoint.position
	self.get_node(spawnNode).add_child(enemy_instance)
	enemiesSpawned += 1
	timer.start(SPAWN_TIME)
	emit_signal("enemy_spawned")
	
func checkFreeSpawnPoint():
	for spawn in spawnPoints.get_children():
		if spawn.blocked == false:
			return true
	return false
			
func freeSpawnPoint() -> int:
	var counter : int = 0
	for spawn in spawnPoints.get_children():
		if spawn.blocked == false:
			return counter
		counter += 1
	return counter
	
func freeSpawnPoints():
	var freePoints = []
	for spawn in spawnPoints.get_children():
		if spawn.blocked == false:
			freePoints.append(spawn)
	return freePoints

func _on_Timer_timeout():
	if enemiesSpawned < NUMBER_OF_ENEMIES:
		if checkFreeSpawnPoint():
			var spawnPoints = freeSpawnPoints()
			var chosenPoint = spawnPoints[rng.randi_range(0, spawnPoints.size()-1)]
			spawn(chosenPoint)
			timer.start(SPAWN_TIME)
	else:
		pass
	
func _on_LevelSwitcher_round_start():
	timer.start(SPAWN_TIME)
