extends CharacterBody2D

signal character_hit

var screen_size # Size of the game window.
var speed = 400 # How fast the player will move (pixels/sec).
const JUMP_VELOCITY = -450.0 #up axis on Y is negative
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hit = false
var bounceBack = false
var is_in_water: bool = false

@onready var animatedSprite = $AnimatedSprite2D
@onready var coyote_timer = $Coyote #tracks coyote time
@onready var iframe_timer = $IFrames
@onready var throw_timer = $rethrow
@export var Projectile : PackedScene
@export var Swim_Gravity : float = 0.15

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("connect_hud")
	add_to_group("character")
	screen_size = get_viewport_rect().size
	$right_kick_check.get_child(0).disabled = true
	$left_kick_check.get_child(0).disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	$left_kick_check.get_child(0).disabled = true
	$right_kick_check.get_child(0).disabled = true 
	
	var is_active = Global.num
	
	if is_active == 1:
		$AnimatedSprite2D.visible = true
		animatedSprite = $AnimatedSprite2D
	elif is_active == 2:
		$femaleSprite.visible = true
		animatedSprite = $femaleSprite
	elif is_active == 3:
		$soldierSprite.visible = true
		animatedSprite = $soldierSprite
	elif is_active == 4:
		$zombieSprite.visible = true
		animatedSprite = $zombieSprite
	elif is_active == 5:
		$adventurerSprite.visible = true
		animatedSprite = $adventurerSprite
	
	if not is_on_floor():
		if !(is_in_water):
			velocity.y += gravity * delta
		else:
			velocity.y += gravity * delta * Swim_Gravity
	
	if hit and is_on_floor():# add the bounce and color change when character is hit
		velocity.y = JUMP_VELOCITY
		set_modulate(Color(0.5, 0, 0, 1))

	if Input.is_action_just_pressed("jump") and (is_on_floor() || !coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY
	
	var direction = 0
	var animation = "none"
	
	if Input.is_action_pressed("walk_right"):
		direction = 1
		animation = "walk"
	elif Input.is_action_pressed("walk_left"):
		direction = -1
		animation = "walk"
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
	elif Input.is_action_pressed("swim_right"):
		direction = 1
		animation = "swim"
	elif Input.is_action_pressed("swim_left"):
		direction = -1
		animation = "swim"
	elif Input.is_action_pressed("slide_right"):
		direction = 1
		animation = "slide"
	elif Input.is_action_pressed("slide_left"):
		direction = -1
		animation = "slide"
	elif Input.is_action_pressed("climb"):
		velocity.y += 1
	elif hit:
		direction = -0.25
		animation = "hit"
	
	if hit and velocity.y > JUMP_VELOCITY*0.1: # turns off color after player is hit
		set_modulate(Color(1, 1, 1, 1))
		hit = false

	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	# kick enemy
	update_animations(velocity, animation)
	if Input.is_action_pressed("kick"):
		update_animations(Vector2(0, 0), "kick")

		if velocity.x < 0:
			$left_kick_check.get_child(0).disabled = false
		else: 
			$right_kick_check.get_child(0).disabled = false

	if Input.is_action_pressed("cheer"):
		update_animations(Vector2(0, 0), "cheer")
		
	if Input.is_action_pressed("throw"):
		update_animations(Vector2(0, 0), "throw")
		if throw_timer.is_stopped():
			throw()
		
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
		
func update_animations(velocity, animation):
	
	
	if velocity.x == 0 and velocity.y == 0:
		animatedSprite.animation = "idle"
	
	if velocity.x != 0:
		animatedSprite.flip_h = velocity.x < 0

	if animation == "hit":
		animatedSprite.animation = "hurt"
	elif velocity.y < 0:
		animatedSprite.animation = "jump"
	elif velocity.y > 0:
		animatedSprite.animation = "duck"
	elif animation == "walk":
		animatedSprite.animation = "walk"
	elif animation =="swim":
		animatedSprite.animation = "swim"
	elif animation == "slide":
		animatedSprite.animation = "slide"
	elif animation == "kick":
		animatedSprite.animation = "kick"
	elif animation == "cheer":
		animatedSprite.animation = "celebrate"
	elif animation == "throw":
		animatedSprite.animation = "throw"
	

# this function is called in enemy script when player jumps on top and collides with
# the top collision shape
func bounce():
	velocity.y = JUMP_VELOCITY * 0.5

# when enemy touches the side check collision shape
func _on_side_check_body_entered(body):
	if iframe_timer.is_stopped():
		iframe_timer.start()
		hit = true
		emit_signal("character_hit")

func throw():
	var projectile = Projectile.instantiate()
	projectile.position = position
	if animatedSprite.flip_h:
		projectile.flipDirection()
		projectile.position.x += -15
	else:
		projectile.position.x += 75
	projectile.position.y += 50
	#projectile.position.x += (int) (animatedSprite.flip_h) * 50
	get_parent().add_child(projectile)
	#projectile.set_as_toplevel(true)
	
	throw_timer.start()

func cheer():
	update_animations(Vector2(0, 0), "cheer")
#auto restart for yellow
func _on_yellow_fallzone_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/levels/yellow/yellow1.tscn")
	
func _on_yellow2_fallzone_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/levels/yellow/yellow_2.tscn")

# using call deferred so that the level restarts at the end of the frame (safer per godot)
func _on_fire_fallzone_body_entered(body):
	call_deferred("restartLevel")

func restartLevel():
	get_tree().change_scene_to_file(get_tree().current_scene.scene_file_path)
	
func _on_left_kick_check_body_entered(body):
	#print("player kicked enemy on the left")
	body.kicked("left")

func _on_right_kick_check_body_entered(body):
	#print("player kicked enemy on the right")
	body.kicked("right")

func _on_ifallzone_body_entered(body):
	call_deferred("restartLevel")

func _on_blue_fallzone_body_entered(body):
	call_deferred("restartLevel")

func _on_out_of_gems():
	call_deferred("restartLevel")


func connect_hud():
	for hud in get_tree().get_nodes_in_group("hud"):
		hud.connect("out_of_gems", Callable(self, "_on_out_of_gems"))
