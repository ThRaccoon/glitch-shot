class_name Player extends CharacterBody2D

@export var a_sprite: AnimatedSprite2D
@export var hitbox: CollisionShape2D
@export var health_comp: HealthComponent

var hero_data: HeroData
var current_ability: BaseAbility
var is_setuped: bool

var damage: float
var move_speed: float
 
func _ready() -> void:
	_setup()
	
func _physics_process(_delta: float) -> void:
	if !is_setuped:
		return
	
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("ability"):
		current_ability.cast()
	
	if dir.x > 0:
		a_sprite.flip_h = false
	elif dir.x < 0:
		a_sprite.flip_h = true
	
	if velocity.length() > 0:
		a_sprite.play("run")
	else:
		a_sprite.play("idle")
	
	velocity = dir * move_speed
	move_and_slide()

func _on_health_component_health_changed_cmd(_current_hp: float, _max_hp: float) -> void:
	pass

func _on_health_component_health_depleted_cmd() -> void:
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
		push_error("ability_scene is null!")
		return
	
	current_ability = hero_data.ability_scene.instantiate()
	add_child(current_ability)
	
	current_ability.setup(self, hero_data.ability_cooldown)

func _setup_visuals() -> void:
	if not hero_data.animations:
		push_error("animations is null!")
		return
	
	a_sprite.sprite_frames = hero_data.animations

func _setup_sounds() -> void:
	pass
	
func _setup_hitbox() -> void:
	hitbox.shape.size = hero_data.hitbox_size
	hitbox.position = hero_data.hitbox_pos

func _setup_components() -> void:
	if not health_comp:
		push_error("health_comp is null!")
		return
	
	health_comp.setup(hero_data.health, hero_data.max_health)
