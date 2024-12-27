extends CanvasLayer

@export_file var next_scene_path
var gems = 0

func _ready():
	# this allows us to click buttons when tree is paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED 
	
	# dim the gems on the popup then hide it
	$Gem1.set_modulate(Color(1, 1, 1, 0.5))
	$Gem2.set_modulate(Color(1, 1, 1, 0.5))
	$Gem3.set_modulate(Color(1, 1, 1, 0.5))
	hide()
	pass

# for this to work when adding gems to the level
# click on the gem, go to node, click on "gem_collected"
# and connect this function for all 3 gems
func _on_gem_collected():
	print("got gem gems: ", gems)
	gems = gems + 1
	
func _on_character_hit():
	print("got hit gems: ", gems)
	gems = gems - 1

# go to the next scene !! for this to work need to add the next scene on inspector!!
func _on_next_level_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(next_scene_path)

# restarts whatever scene this is on
func _on_retry_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
	
# when the final flag is reached
# for this to work need to add the finish_flag to the level scene
# go to node tab for the finish_flag and select final_flag_entered and
# connect this function
func _on_final_flag_entered():
	show()
	get_tree().paused = true
	if gems >= 1:
		$Gem1.set_modulate(Color(1, 1, 1, 1))
	if gems >= 2:
		$Gem2.set_modulate(Color(1, 1, 1, 1))
	if gems >= 3:
		$Gem3.set_modulate(Color(1, 1, 1, 1))

