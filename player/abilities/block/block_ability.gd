extends BaseAbility

@export var block_duration: float

# override
func _on_cast() -> void:
	super()
	
	if player.health_comp:
		player.health_comp.is_damage_blocked = true
		
		await get_tree().create_timer(block_duration).timeout
		
		player.health_comp.is_damage_blocked = false
