extends CharacterBody2D

var speed = 600
var userDirection = 1
var grav = 0.075
var damp = false

func _ready():
	velocity.x = userDirection * speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# bounce collision physics
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())

	# slows the velocity after throwing
	velocity.x *= 0.99

	# dampens the speed and makes it stop faster if it hits something
	if damp:
		velocity.y += 90 
	else:
		velocity.y += 10

	# if it loses all velocity it frees
	if is_on_floor() && velocity.x == 0:
		queue_free()
	
	# if its stuck at the same y velocity it frees or else it'll slide
	if velocity.y == 90 && $slideTimer.is_stopped():
		$slideTimer.start()
		
	if velocity.y != 90 && !$slideTimer.is_stopped():
		$slideTimer.stop()

	move_and_slide()
	$Sprite2D.rotation += 0.2 #illusion of spinning

# when it hits enemies injure them, else just dampens velocity
func _on_body_entered(body):

	if body.name.contains("enemy"):
		body.hit(userDirection)
	damp = true;

func flipDirection():
	userDirection *= -1

# frees after 1 second
func _on_lifespan_timeout():
	queue_free()

# frees after sliding too long
func _on_slide_timer_timeout():
	queue_free()
