extends BaseAbility

@export var bonus_move_speed: float
@export var sprint_duration: float

var _original_move_speed: float

# override
func _on_cast() -> void:
	super()
	
	_original_move_speed = player.move_speed
	player.move_speed += bonus_move_speed
	
	await get_tree().create_timer(sprint_duration).timeout
	
	player.move_speed = _original_move_speed
