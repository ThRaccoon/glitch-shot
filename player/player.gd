class_name Player extends CharacterBody2D

@export var hero_a_sprite: AnimatedSprite2D
@export var hero_collider: CollisionShape2D
@export var audio_player: AudioStreamPlayer2D
@export var health_comp: HealthComponent

@export var bomb_scene: PackedScene

# Stats
var move_speed: float

# Ability data
var hero_data: HeroData
var crnt_ability: BaseAbility

var is_setuped: bool
var crnt_bomb_count: int
var input_dir: Vector2 
var entities_container: Node2D

func _ready() -> void:
	_setup()
	
	entities_container = get_tree().root.find_child("EntitiesContainer", true, false)
	
func _process(_delta: float) -> void:
	if not is_setuped:
		return
	
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("throw_bomb"):
		_throw_bomb()
	
	if Input.is_action_pressed("ability"):
		crnt_ability.cast()
	
	var dir_to_mouse: Vector2 = global_position.direction_to(get_global_mouse_position())
	var is_facing_right: bool = Vector2.RIGHT.dot(dir_to_mouse) >= 0
	
	hero_a_sprite.flip_h = not is_facing_right
	 
	if velocity.length() > 0:
		hero_a_sprite.play("run")
	else:
		hero_a_sprite.play("idle")
	
func _physics_process(_delta: float) -> void:
	if not is_setuped:
		return
		
	velocity = input_dir * move_speed
	move_and_slide()

func _on_health_component_health_changed_sig(_current_hp: float, _max_hp: float) -> void:
	audio_player.stream = hero_data.hurt_sfx
	audio_player.play()

func _on_health_component_health_depleted_sig() -> void:
	audio_player.stream = hero_data.death_sfx
	audio_player.play()
	
	visible = false
	
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	
	await audio_player.finished
	
	queue_free()

func set_hero_data(data: HeroData) -> void:
	hero_data = data
	
func _setup() -> void:
	if not hero_data:
		push_error("hero_data is null!")
		return
	
	_setup_stats()
	_setup_ability()
	_setup_visuals()
	_setup_collider()
	_setup_components()
	
	is_setuped = true
	
func _setup_stats() -> void:
	move_speed = hero_data.move_speed
	
func _setup_ability() -> void:
	if not hero_data.ability_scene:
		push_error("hero_data.ability_scene is null")
		return
	
	crnt_ability = hero_data.ability_scene.instantiate()
	add_child(crnt_ability)
	
	crnt_ability.setup(self, hero_data.ability_cooldown)

func _setup_visuals() -> void:
	if not hero_data.animations:
		push_error("hero_data.animations are null")
		return
	
	hero_a_sprite.sprite_frames = hero_data.animations
	
func _setup_collider() -> void:
	if not hero_collider.shape is RectangleShape2D:
		push_error("Heroes are ment to work with RectangleShape2D")
		return
	
	hero_collider.shape.size = hero_data.collider_size
	hero_collider.position = hero_data.collider_pos

func _setup_components() -> void:
	if not health_comp:
		push_error("health_comp is null")
		return
	
	health_comp.setup(hero_data.health, hero_data.max_health)
	
func _throw_bomb() -> void:
	if crnt_bomb_count <= 0:
		return
	
	crnt_bomb_count -= 1
	
	if not bomb_scene:
		push_warning("bomb_scene is null")
		return
		
	var bomb = bomb_scene.instantiate()
	
	entities_container.add_child(bomb)
	bomb.global_position = global_position
