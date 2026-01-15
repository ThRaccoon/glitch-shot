class_name MeleeEnemy extends BaseEnemy

@export var hitbox_area: Area2D
@export var hitbox_collider: CollisionShape2D

var melee_enemy_data: MeleeEnemyData

# override
func _ready() -> void:
	melee_enemy_data = base_enemy_data as MeleeEnemyData
	super()
	
func _physics_process(_delta: float) -> void:
	if not is_setuped:
		return
		
	if not player_ref:
		return
	
	if can_attack:
		var overlapping_bodies = hitbox_area.get_overlapping_bodies()
		for body in overlapping_bodies:
			if body == player_ref:
				_attack(body)
				break
	
	var dist = global_position.distance_to(player_ref.global_position)
	
	if dist <= base_enemy_data.stopping_distance:
		velocity = Vector2.ZERO
	else:
		pathfinder.target_position = player_ref.global_position
		if not pathfinder.is_navigation_finished():
			var next_path_pos = pathfinder.get_next_path_position()
			var direction = global_position.direction_to(next_path_pos)
			velocity = direction * move_speed
			move_and_slide()
		
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		if can_attack:
			_attack(body)
		
# override
func _setup_collider() -> void:
	super()
 
	if not hitbox_collider.shape is RectangleShape2D:
		push_warning("Melee enemies are ment to work with RectangleShape2D")
		return
		
	var hitbox_collider_shape = hitbox_collider.shape as RectangleShape2D
	hitbox_collider_shape.size = melee_enemy_data.hitbox_size
	hitbox_area.position = melee_enemy_data.hitbox_pos

func _attack(player: Player) -> void:
	player.health_comp.take_damage(damage)
	can_attack = false
	attack_timer.start()
