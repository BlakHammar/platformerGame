extends Node2D

var velocity = 0

var force = 0

var height = 0

var target_height = 0

@onready var collision = $Area2D/CollisionShape2D

var index = 0

var motion_factor = 0.02

signal splash

func water_update(spring_constant, dampening):
	#update the height based on the current position
	height = position.y
	
	var x = height - target_height
	var loss = -dampening * velocity
	force = - spring_constant * x + loss
	velocity += force
	position.y += velocity
	pass

func initialize(x_position, id):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
	index = id
	
func set_collision_width(value):
	var extents = collision.shape.size
	var new_extents = Vector2(value/2, extents.y)
	collision.shape.set_size(new_extents)


func _on_area_2d_body_entered(body):
	var speed = body.velocity.y * motion_factor
	emit_signal("splash", index, speed)
	pass # Replace with function body.

