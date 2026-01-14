class_name Destructible extends Area2D

@export var destructible_sprite: Sprite2D
@export var collider: CollisionShape2D
@export var health_comp: HealthComponent

var destructible_data: DestructibleData

func _on_health_component_health_changed_sig(current_hp: Variant, max_hp: Variant) -> void:
	if destructible_data.textures.size() == 1:
		return
	
	var damage_progress = 1.0 - (current_hp / max_hp)
	var index = floor(damage_progress * destructible_data.textures.size())
	index = clampi(index, 0, destructible_data.textures.size() - 1)
	destructible_sprite.texture = destructible_data.textures[index]
	
func _on_health_component_health_depleted_sig() -> void:
	if randf() <= destructible_data.drop_chance:
		_spawn_reward()
	
	queue_free()
	
func setup(data: DestructibleData) -> void:
	destructible_data = data
	
	if not destructible_data:
		push_warning("destructible_data is null")
		return
		
	_setup_visuals()
	_setup_collider()
	_setup_components()
	
func _setup_visuals() -> void:
	if destructible_data.textures.is_empty():
		push_warning("destructible_data.textures is empty")
		return
	
	destructible_sprite.texture = destructible_data.textures[0]
	
func _setup_collider() -> void:
	if not collider.shape is RectangleShape2D:
		push_error("Destructibles are ment to work with RectangleShape2D")
		return
	
	collider.shape.size = destructible_data.collider_size
	collider.position = destructible_data.collider_pos
	
func _setup_components() -> void:
	if not health_comp:
		push_warning("health_comp is null")
		return
	
	health_comp.setup(destructible_data.health, destructible_data.health)
	
func _spawn_reward() -> void:
	match destructible_data.drop_type:
		DestructibleData.DestructibleType.CHEST:
			SignalBus.spawn_rand_gun_sig.emit(global_position)
		DestructibleData.DestructibleType.CRATE:
			SignalBus.spawn_rand_loot_sig.emit(global_position)
