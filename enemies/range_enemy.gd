class_name RangeEnemy extends BaseEnemy

var range_enemy_data: RangeEnemyData

# override
func _ready() -> void:
	range_enemy_data = base_enemy_data as RangeEnemyData
	super()
	
func _physics_process(_delta: float) -> void:
	if not is_setuped:
		return
		
	if not player_ref:
		return
	
	var dist = global_position.distance_to(player_ref.global_position)
	
	if dist <= base_enemy_data.stopping_distance:
		velocity = Vector2.ZERO
		a_sprite.stop()
		a_sprite.frame = 0
		if can_attack:
			_cast()
	else:
		if not a_sprite.is_playing():
			a_sprite.play()
		pathfinder.target_position = player_ref.global_position
		if not pathfinder.is_navigation_finished():
			var next_path_pos = pathfinder.get_next_path_position()
			var direction = global_position.direction_to(next_path_pos)
			velocity = direction * move_speed
			move_and_slide()
			
func _cast() -> void:
	var spell = range_enemy_data.spell_scene.instantiate() as Spell
	
	get_parent().add_child(spell)
	spell.global_position = global_position
	
	var dir = global_position.direction_to(player_ref.global_position)
	spell.look_at(player_ref.global_position)
	
	spell.setup(
		damage,                          
		range_enemy_data.spell_speed,     
		range_enemy_data.spell_lifetime,  
		dir,                
		range_enemy_data.spell_texture
	)
	
	can_attack = false
	attack_timer.start(attack_speed)
