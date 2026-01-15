class_name BaseEnemy extends CharacterBody2D

@export var a_sprite: AnimatedSprite2D
@export var collider: CollisionShape2D
@export var pathfinder: NavigationAgent2D
@export var attack_timer: Timer
@export var health_comp: HealthComponent

var base_enemy_data: BaseEnemyData

var damage: float
var attack_speed: float
var move_speed: float

var is_setuped: bool
var can_attack: bool = true
var player_ref: Player

func _ready() -> void:
	_setup()
	a_sprite.play("run")
	
func _process(_delta: float) -> void:
	if not is_setuped:
		return
		
	if not player_ref:
		return
	
	a_sprite.flip_h = player_ref.global_position.x < global_position.x
		
func _on_attack_timer_timeout() -> void:
	can_attack = true

func _on_health_component_health_changed_sig(_current_hp: Variant, _max_hp: Variant) -> void:
	pass

func _on_health_component_health_depleted_sig() -> void:
	queue_free()
	
func set_enemy_data(data: BaseEnemyData) -> void:
	base_enemy_data = data
	
func _setup() -> void:
	if not base_enemy_data:
		push_warning("base_enemy_data is null!")
		return
	
	_setup_stats()
	_setup_visuals()
	_setup_collider()
	_setup_timers()
	_setup_components()
	
	is_setuped = true
	
func _setup_stats() -> void:
	damage = base_enemy_data.damage
	attack_speed = base_enemy_data.attack_speed
	move_speed = base_enemy_data.move_speed
	
func _setup_visuals() -> void:
	if not base_enemy_data.animations:
		push_warning("base_enemy_data.animations are null!")
		return
	
	a_sprite.sprite_frames = base_enemy_data.animations
	
func _setup_collider() -> void:
	if not collider.shape is RectangleShape2D:
		push_warning("Enemies collider is ment to work with RectangleShape2D")
		return
	
	var collider_shape = collider.shape as RectangleShape2D
	collider_shape.size = base_enemy_data.collider_size
	collider.position = base_enemy_data.collider_pos

func _setup_timers() -> void:
	attack_timer.wait_time = attack_speed

func _setup_components() -> void:
	if not health_comp:
		push_warning("health_comp is null!")
		return
	
	health_comp.setup(base_enemy_data.health, base_enemy_data.max_health)
