class_name StunEffect extends Node

var stun_duration: float

func _ready() -> void:
	var enemy = get_parent()
	
	if enemy.has_method("apply_stun"):
		enemy.apply_stun(true)
	
	await get_tree().create_timer(duration).timeout
	
	if is_instance_valid(enemy) and enemy.has_method("apply_stun"):
		enemy.apply_stun(false)
	
	queue_free()
