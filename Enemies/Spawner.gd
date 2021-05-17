extends Node

export (PackedScene) var ENEMY_OBJECT
export var spawnNode := NodePath()
export var SPAWN_TIME = 1

export var NUMBER_OF_ENEMIES = 10

onready var spawnPoints = $SpawnPoints
onready var spawnedObjects = $SpawnedObjects
onready var timer = $Timer
onready var collisionTimer = $CollisionTimer

var rng = RandomNumberGenerator.new() 
var enemiesInWave
var enemiesSpawned = 0
var freeSpawnPoint = false
var spawnEnemy = true

func _ready():
	timer.start(SPAWN_TIME)

#func _process(delta):
	#print(checkFreeSpawnPoint())

func spawn(spawnPoint: int):
	var enemy_instance = ENEMY_OBJECT.instance()
	enemy_instance.set_name("Fighter")
	enemy_instance.position = spawnPoints.get_child(spawnPoint).position
	self.get_node(spawnNode).add_child(enemy_instance)
	enemiesSpawned += 1
	timer.start(SPAWN_TIME)
	
func checkFreeSpawnPoint():
	for spawn in spawnPoints.get_children():
		if spawn.blocked == false:
			return true
	return false
			
func freeSpawnPoint() -> int:
	var spawnFound = false
	var counter : int = 0
	for spawn in spawnPoints.get_children():
		if spawn.blocked == false:
			return counter
		counter += 1
	return counter

func _on_Timer_timeout():
	if enemiesSpawned < NUMBER_OF_ENEMIES:
		if checkFreeSpawnPoint():
			spawn(freeSpawnPoint())
			timer.start(SPAWN_TIME)
	else:
		pass
	
