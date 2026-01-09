extends BaseAbility

@export var blink_ray: RayCast2D
@export var blink_distance: float

# override
func _on_cast() -> void:
	super()
	
	var mouse_pos = get_global_mouse_position()
	var blink_dir = player.global_position.direction_to(mouse_pos)
	
	blink_ray.target_position = blink_dir * blink_distance
	blink_ray.force_raycast_update()
	
	if blink_ray.is_colliding():
		player.global_position = blink_ray.get_collision_point()
	else:
		player.global_position += blink_dir * blink_distance
