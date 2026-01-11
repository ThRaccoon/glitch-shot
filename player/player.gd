class_name Player extends CharacterBody2D

@export var a_sprite: AnimatedSprite2D
@export var collider: CollisionShape2D
@export var health_comp: HealthComponent

var hero_data: HeroData
var crnt_ability: BaseAbility

var is_setuped: bool
var damage: float
var move_speed: float

var input_dir: Vector2 

func _ready() -> void:
	_setup()
	
func _process(_delta: float) -> void:
	if not is_setuped:
		return
	
	input_dir = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("ability"):
		crnt_ability.cast()
	
	var dir_to_mouse: Vector2 = global_position.direction_to(get_global_mouse_position())
	var is_facing_right: bool = Vector2.RIGHT.dot(dir_to_mouse) >= 0
	
	a_sprite.flip_h = not is_facing_right
	 
	if velocity.length() > 0:
		a_sprite.play("run")
	else:
		a_sprite.play("idle")
	
func _physics_process(_delta: float) -> void:
	if not is_setuped:
		return
		
	velocity = input_dir * move_speed
	move_and_slide()

func _on_health_component_health_changed_sig(_current_hp: float, _max_hp: float) -> void:
	pass

func _on_health_component_health_depleted_sig() -> void:
	pass

func set_hero_data(data: HeroData) -> void:
	hero_data = data

func _setup() -> void:
	if not hero_data:
		push_error("hero_data is null!")
		return
	
	_setup_stats()
	_setup_ability()
	_setup_visuals()
	_setup_sounds()
	_setup_hitbox()
	_setup_components()
	
	is_setuped = true
	
func _setup_stats() -> void:
	damage = hero_data.damage
	move_speed = hero_data.move_speed
	
func _setup_ability() -> void:
	if not hero_data.ability_scene:
		push_error("ability_scene is null")
		return
	
	crnt_ability = hero_data.ability_scene.instantiate()
	add_child(crnt_ability)
	
	crnt_ability.setup(self, hero_data.ability_cooldown)

func _setup_visuals() -> void:
	if not hero_data.animations:
		push_error("animations are null")
		return
	
	a_sprite.sprite_frames = hero_data.animations

func _setup_sounds() -> void:
	pass
	
func _setup_hitbox() -> void:
	collider.shape.size = hero_data.hitbox_size
	collider.position = hero_data.hitbox_pos

func _setup_components() -> void:
	if not health_comp:
		push_error("health_comp is null")
		return
	
	health_comp.setup(hero_data.health, hero_data.max_health)
