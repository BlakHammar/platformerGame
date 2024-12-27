extends Node2D

func _ready():
	pass
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/blueLevel/blue_level.tscn")

func on_load_level_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/load_level.tscn")

func on_exit_pressed() -> void:
	get_tree().quit()
