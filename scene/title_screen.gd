# titlescreen.gd - attach this to the root Control node
extends Control

func _ready() -> void:
	# Make sure the start button is connected to the method
	$Button.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed() -> void:
	# Change to the main game scene
	get_tree().change_scene_to_file("res://scene/main.tscn")  # Adjust path to match your scene location
