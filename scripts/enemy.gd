extends CharacterBody2D

@export var direction = -1
@onready var animatedSprite = $AnimatedSprite2D
@onready var collisionShape = $CollisionShape2D
@onready var floorCheck = $floor_check
@onready var topCheck = $top_check

var speed = 50
var hitRight = false
var hitLeft = false

func _ready():
	animatedSprite.play("walk")
	floorCheck.position.x = collisionShape.shape.extents.x * direction
	
func _physics_process(delta):
	
	if is_on_wall() or not floorCheck.is_colliding() and is_on_floor(): # if it hits the wall or reaches cliff, switch direction
		direction *= -1
		floorCheck.position.x = collisionShape.shape.extents.x * direction
		
	floorCheck.position.x = collisionShape.shape.extents.x * direction

	velocity.y += 20
	velocity.x = direction * speed
	if hitRight:
		velocity.x += -200
		velocity.y += (velocity.y*-1) - 200
	
	if hitLeft:
		velocity.x += 200
		velocity.y += (velocity.y*-1) - 200
		
	move_and_slide()


func _on_top_check_body_entered(body):
	animatedSprite.play("squished")
	speed = 0
	set_collision_layer_value(3, false) # turns off its layer
	set_collision_mask_value(1, false) # turns off mask layer to stop interaction with player
	topCheck.set_collision_layer_value(3, false)
	topCheck.set_collision_mask_value(1, false)

	$Timer.start()
	body.bounce() # causes the player to bounce, body is the body that hit the sprite

func _on_timer_timeout():
	queue_free()

func injured():
	set_collision_layer_value(3, false) # turns off its layer
	set_collision_mask_value(1, false) # turns off mask layer to stop interaction with player
	topCheck.set_collision_layer_value(3, false)
	topCheck.set_collision_mask_value(1, false)
	
	$KickTimer.start()
	$Timer.start()
	
func kicked(direction):
	if direction == "left":
		hitRight = true
	else:
		hitLeft = true
	injured()

func hit(direction):
	if direction == 1:
		hitLeft = true
	else:
		hitRight = true
	injured()
	
func _on_kick_timer_timeout():
	animatedSprite.play("squished")
	speed = 0
	hitLeft = false
	hitRight = false
	
