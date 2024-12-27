class_name LoadLevel
extends MarginContainer

@onready var level_1_button = $"Control/VBoxContainer/Top Levels/VBoxContainer2/HBoxContainer/Level 1/Level1_Button" as Button
@onready var level_2_button = $"Control/VBoxContainer/Top Levels/VBoxContainer2/HBoxContainer/Level 2/Level2_Button" as Button
@onready var level_3_button = $"Control/VBoxContainer/Top Levels/VBoxContainer2/HBoxContainer/Level 3/Level3_Button" as Button
@onready var level_4_button = $"Control/VBoxContainer/Top Levels/VBoxContainer2/HBoxContainer/Level 4/Level4_Button" as Button
@onready var level_5_button = $"Control/VBoxContainer/Bottom Levels/VBoxContainer2/HBoxContainer/Level 5/Level5_Button" as Button
@onready var level_6_button = $"Control/VBoxContainer/Bottom Levels/VBoxContainer2/HBoxContainer/Level 6/Level6_Button" as Button
@onready var level_7_button = $"Control/VBoxContainer/Bottom Levels/VBoxContainer2/HBoxContainer/Level 7/Level7_Button" as Button
@onready var level_8_button = $"Control/VBoxContainer/Bottom Levels/VBoxContainer2/HBoxContainer/Level 8/Level8_Button" as Button


@onready var start_level1 = preload("res://scenes/levels/blueLevel/blue_level.tscn") as PackedScene
@onready var start_level2 = preload("res://scenes/levels/blueLevel/blue_level_2.tscn") as PackedScene
@onready var start_level3 = preload("res://scenes/levels/fire_theme/fire_level1.tscn") as PackedScene
@onready var start_level4 = preload("res://scenes/levels/fire_theme/fire_level2.tscn") as PackedScene
@onready var start_level5 = preload("res://scenes/levels/ilevel1.tscn") as PackedScene
@onready var start_level6 = preload("res://scenes/levels/darkgreen2.tscn") as PackedScene
@onready var start_level7 = preload("res://scenes/levels/yellow/yellow1.tscn") as PackedScene
@onready var start_level8 = preload("res://scenes/levels/yellow/yellow_2.tscn") as PackedScene



func _ready():
	level_1_button.button_down.connect(on_level1_pressed)
	level_2_button.button_down.connect(on_level2_pressed)
	level_3_button.button_down.connect(on_level3_pressed)
	level_4_button.button_down.connect(on_level4_pressed)
	level_5_button.button_down.connect(on_level5_pressed)
	level_6_button.button_down.connect(on_level6_pressed)
	level_7_button.button_down.connect(on_level7_pressed)
	level_8_button.button_down.connect(on_level8_pressed)

func on_level1_pressed() -> void:
	get_tree().change_scene_to_packed(start_level1)
	

func on_level2_pressed() -> void:
	get_tree().change_scene_to_packed(start_level2)
	

func on_level3_pressed() -> void:
	get_tree().change_scene_to_packed(start_level3)
	

func on_level4_pressed() -> void:
	get_tree().change_scene_to_packed(start_level4)
	

func on_level5_pressed() -> void:
	get_tree().change_scene_to_packed(start_level5)
	

func on_level6_pressed() -> void:
	get_tree().change_scene_to_packed(start_level6)
	

func on_level7_pressed() -> void:
	get_tree().change_scene_to_packed(start_level7)
	

func on_level8_pressed() -> void:
	get_tree().change_scene_to_packed(start_level8)
