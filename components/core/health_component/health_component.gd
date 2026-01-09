class_name HealthComponent extends Node

signal health_changed_cmd(current_hp, max_hp)
signal health_depleted_cmd

var current_health: float
var max_health: float
var is_damage_blocked: bool

func setup(init_hp: float, init_max_hp: float) -> void:
	max_health = init_max_hp
	current_health = init_hp
	health_changed_cmd.emit(current_health, max_health)

func take_damage(amount: float) -> void:
	if is_damage_blocked:
		return
	
	if amount <= 0:
		return
	
	current_health -= amount
	
	health_changed_cmd.emit(current_health, max_health)
	
	if current_health <= 0:
		health_depleted_cmd.emit()
		
func heal(amount: float) -> void:
	if amount <= 0:
		return
	
	current_health += amount
	
	if current_health > max_health:
		current_health = max_health
	
	health_changed_cmd.emit(current_health, max_health)
