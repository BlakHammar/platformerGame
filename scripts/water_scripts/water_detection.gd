extends Area2D

signal water_state_changed(is_in_water)

var is_in_water: bool = false

func _on_area_2d_body_entered(body):
	if (is_in_water == false):
		var overlapping_bodies = get_overlapping_bodies()
		if (overlapping_bodies.size() >= 1):
			is_in_water= true
			emit_signal("in_water", is_in_water)

func _on_area_2d_body_exited(body):
	if (is_in_water == true):
		var overlapping_bodies = get_overlapping_bodies()
		if (overlapping_bodies.size() == 1):
			is_in_water = true
			emit_signal("in_water", is_in_water)
