extends Area2D

var blocked = false

func _on_SpawnPoint_body_entered(body):
	blocked = true


func _on_SpawnPoint_body_exited(body):
	blocked = false
