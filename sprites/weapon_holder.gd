extends Node2D

func _process(_delta: float) -> void:
	# Gets the global position of the mouse cursor
	var mouse_pos = get_global_mouse_position()
	
	# Rotates the node's positive X-axis (the "front") to point at the position
	look_at(mouse_pos)
