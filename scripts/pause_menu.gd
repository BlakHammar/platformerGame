extends Control

@onready var quit = load("res://scenes/main_menu.tscn") as PackedScene

func _ready():# this allows us to click buttons when tree is paused
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()
	
func _on_resume_pressed():
	get_tree().paused=false
	resume()

func _on_restart_pressed():
	get_tree().paused=false
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_packed(quit)
	
func _process(delta):
	testEsc()

func _on_button_pressed():
	pass # Replace with function body.

func _on_pause_button_pressed():
	pause()

