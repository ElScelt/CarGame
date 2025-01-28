# world.gd
extends Node

@onready var finish_area = $FinishArea
@onready var kart = $Kart

func _ready() -> void:
	if finish_area and kart:
		# Make sure this path matches your actual node structure
		var timer_node = kart.get_node("Node2D")
		if timer_node:
			finish_area.kart_timer = timer_node
			print("Timer node connected successfully")  # Debug print
		else:
			print("Failed to find timer node!")  # Debug print
