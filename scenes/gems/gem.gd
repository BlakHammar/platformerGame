extends Area2D

signal gem_collected

func _ready():
	add_to_group("gems")

func _on_body_entered(body):
	emit_signal("gem_collected")
	queue_free()
	
