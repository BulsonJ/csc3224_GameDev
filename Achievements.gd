extends Node

var enemies_killed = 0
var time_played
var round_achieved = 1

var time_start = 0
var time_now = 0

func _ready():
	time_start = OS.get_unix_time()
	set_process(true)
	

func _process(delta):
	time_now = OS.get_unix_time()
	var elapsed = time_now - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var str_elapsed = "%02dm:%02ds" % [minutes, seconds]
	time_played = str_elapsed
	
func reset():
	enemies_killed = 0
	
	round_achieved = 1
	time_start = 0
	time_start = OS.get_unix_time()
	
