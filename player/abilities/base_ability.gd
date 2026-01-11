class_name BaseAbility extends Node2D

var player: Player

var cooldown: float
var is_ready: bool

func setup(player_: Player, cooldown_: float) -> void:
	player = player_
	cooldown = cooldown_
	is_ready = true
	
func cast() -> void:
	if not is_ready:
		return
		
	is_ready = false
		
	_on_cast()
		 
	await get_tree().create_timer(cooldown).timeout
		
	is_ready = true
		
func _on_cast() -> void:
	pass
