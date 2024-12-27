extends Node

func _ready():
	pass
	
func change_song():
	$upbeat.stop()
	$powerful.stop()
	$epic.stop()
	$daisy.stop()
	
	if Global.song == 0:
		$upbeat.play()
	elif Global.song == 1:
		$powerful.play()
	elif Global.song == 2:
		$epic.play()
	elif Global.song == 3:
		$daisy.play()

