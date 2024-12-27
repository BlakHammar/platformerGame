extends CanvasLayer

signal out_of_gems

var gems = 0

func _ready():
	add_to_group("hud")
	call_deferred("connections")
	update_hud()

func _on_character_hit():
	gems = gems - 1
	if gems < 0:
		emit_signal("out_of_gems")
	update_hud()

func _on_gem_collected():
	gems = gems + 1
	update_hud()

func update_hud():
	$Gems.text = str(gems)

func connections():
	for gem in get_tree().get_nodes_in_group("gems"):
		gem.connect("gem_collected", Callable(self, "_on_gem_collected"))
	for character in get_tree().get_nodes_in_group("character"):
		character.connect("character_hit", Callable(self, "_on_character_hit"))
