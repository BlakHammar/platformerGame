extends Node2D

@onready var active = Global.num

# Called when the node entersr the scene tree for the first time.
func _ready():
	$character/AnimatedSprite2D.visible = false
	$character/femaleSprite.visible = false
	$character/soldierSprite.visible = false
	$character/zombieSprite.visible = false
	$character/adventurerSprite.visible = false
	
	if active == 1:
		$character/AnimatedSprite2D.play()
		$character/AnimatedSprite2D.visible = true
	elif active == 2:
		$character/femaleSprite.play()
		$character/femaleSprite.visible = true
	if active == 3:
		$character/soldierSprite.play()
		$character/soldierSprite.visible = true
	if active == 4:
		$character/zombieSprite.play()
		$character/zombieSprite.visible = true
	if active == 5:
		$character/adventurerSprite.play()
		$character/adventurerSprite.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func changePlayer(char):
	$character/AnimatedSprite2D.visible = false
	$character/femaleSprite.visible = false
	$character/soldierSprite.visible = false
	$character/zombieSprite.visible = false
	$character/adventurerSprite.visible = false
	active = char
	Global.num= char


