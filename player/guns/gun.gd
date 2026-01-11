extends Node2D

@export var a_sprite: Sprite2D

var player: Player

func _ready() -> void:
	player = owner
	 
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	
	var dir_to_mouse: Vector2 = player.global_position.direction_to(get_global_mouse_position())
	var is_facing_right: bool = Vector2.RIGHT.dot(dir_to_mouse) >= 0
	
	a_sprite.flip_v = not is_facing_right
