class_name BaseEnemy extends CharacterBody2D

@export var a_sprite: AnimatedSprite2D
@export var collider: CollisionShape2D
@export var pathfinder: NavigationAgent2D
@export var health_comp: HealthComponent

var base_enemy_data: BaseEnemyData
var is_setuped: bool

var damage: float
var attack_speed: float
var move_speed: float

func _ready() -> void:
	_setup()
	
func _process(_delta: float) -> void:
	pass

func _on_health_component_health_changed_cmd(_current_hp: Variant, _max_hp: Variant) -> void:
	pass

func _on_health_component_health_depleted_cmd() -> void:
	pass
	
func set_enemy_data(data: BaseEnemyData) -> void:
	base_enemy_data = data

func _setup() -> void:
	if not base_enemy_data:
		push_error("base_enemy_data is null!")
		return
	
	_setup_stats()
	_setup_visuals()
	_setup_sounds()
	_setup_collider()
	_setup_components()
	
	is_setuped = true
	
func _setup_stats() -> void:
	damage = base_enemy_data.damage
	attack_speed = base_enemy_data.attack_speed
	move_speed = base_enemy_data.move_speed
	
func _setup_visuals() -> void:
	if not base_enemy_data.animations:
		push_error("animations is null!")
		return
	
	a_sprite.sprite_frames = base_enemy_data.animations

func _setup_sounds() -> void:
	pass
	
func _setup_collider() -> void:
	collider.shape.size = base_enemy_data.collider_size
	collider.position = base_enemy_data.collider_pos

func _setup_components() -> void:
	if not health_comp:
		push_error("health_comp is null!")
		return
	
	health_comp.setup(base_enemy_data.health, base_enemy_data.max_health)
