# finish_area.gd
extends Area2D

var kart_timer: Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Kart" and kart_timer:
		kart_timer.on_lap_completed()
