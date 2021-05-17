extends Area2D

var blocked = false

func _on_SpawnPoint_body_entered(_body):
	blocked = true


func _on_SpawnPoint_body_exited(_body):
	blocked = false
