# node_2d.gd
extends Node2D

@onready var timer_label = $HUD/TimerLabel
@onready var lap_times_label = $HUD/LapTimesLabel  # This should be a RichTextLabel node
var start_time = 0
var lap_times = []
var is_timing = false
var first_lap = true

func _ready() -> void:
	timer_label.text = "Cross finish line to start!"
	# Make sure RichTextLabel is properly configured
	if lap_times_label:
		lap_times_label.bbcode_enabled = true
		lap_times_label.clear()
		lap_times_label.append_text("Lap Times will appear here")
		lap_times_label.pop()

func _process(_delta) -> void:
	if is_timing:
		var current_time = Time.get_ticks_msec() - start_time
		update_timer_label(current_time)

func start_timer() -> void:
	if first_lap:
		first_lap = false
		is_timing = true
		start_time = Time.get_ticks_msec()

func on_lap_completed() -> void:
	if !is_timing:
		start_timer()
		return
		
	var lap_time = Time.get_ticks_msec() - start_time
	lap_times.append(lap_time)
	start_time = Time.get_ticks_msec()
	update_lap_times_display()

func update_timer_label(time_ms: float) -> void:
	timer_label.text = "Current Lap: %.3f" % (time_ms / 1000.0)

func update_lap_times_display() -> void:
	lap_times_label.clear()
	lap_times_label.append_text("Lap Times:\n")
	
	for i in range(lap_times.size()):
		var current_time = lap_times[i] / 1000.0
		var lap_number = i + 1
		
		if i > 0:
			if lap_times[i] < lap_times[i-1]:
				# Faster lap - green
				lap_times_label.push_color(Color(0, 1, 0))  # Green
			else:
				# Slower lap - red
				lap_times_label.push_color(Color(1, 0, 0))  # Red
		else:
			# First lap - white
			lap_times_label.push_color(Color(1, 1, 1))  # White
			
		lap_times_label.append_text("Lap %d: %.3f\n" % [lap_number, current_time])
		lap_times_label.pop()  # Pop the color
	
	lap_times_label.pop()  # Pop the alignment
