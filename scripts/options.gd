extends Control

@onready var pop_up = $options_popup
@onready var dropdown =$options_popup/VBoxContainer/choose_character 
@onready var music_list = $options_popup/VBoxContainer/choose_music
@onready var manager = $"../../player"
@onready var dj = $"../../music"
# Called when the node enters the scene tree for the first time.
func _ready():
	pop_up.hide()
	add_items()
	add_music()
	dj.change_song()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_display_options_pressed():
	pop_up.show()

func _on_exit_pressed():
	get_tree().paused = false
	pop_up.hide()
	
func _on_display_options_button_down():
	pop_up.show()

func add_items():
	dropdown.add_item("default")
	dropdown.add_separator()
	dropdown.add_item("female")
	dropdown.add_item("soilder")
	dropdown.add_item("zombie")
	dropdown.add_item("adventurer")
	
func add_music():
	music_list.add_item("upbeat")
	music_list.add_item("power mode")
	music_list.add_item("epic")
	music_list.add_item("daisy")
	music_list.add_item("off")

func _on_choose_character_item_selected(index):
	manager.changePlayer(index)

func _on_choose_music_item_selected(index):
	Global.song = index
	dj.change_song()
