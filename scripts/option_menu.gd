extends Node

@onready var back = preload("res://scenes/main_menu.tscn") as PackedScene

func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(toggled_on):
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)
	
func _on_v_sync_item_selected(index):
	DisplayServer.window_set_vsync_mode(index)

func _on_button_pressed():
	get_tree().change_scene_to_packed(back)
