extends Area2D

var player = null

func _on_PlayerDetectionZone_body_entered(body: Node):
	player = body

func _on_PlayerDetectionZone_body_exited(_body):
	player = null
