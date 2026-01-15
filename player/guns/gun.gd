class_name Gun extends Node2D

@export var gun_sprite: Sprite2D
@export var muzzle: Marker2D
@export var audio_player: AudioStreamPlayer2D
@export var fire_rate_timer: Timer
@export var reload_timer: Timer

# Gun data
var gun_data: GunData
 
var is_setuped: bool
var can_fire: bool = true
var is_reloading: bool
var crnt_ammo_in_mag: int
var player_cb: CharacterBody2D
var entities_container: Node2D

func _ready() -> void:
	SignalBus.load_initial_gun_sig.connect(_setup)
	SignalBus.swap_gun_sig.connect(_swap_gun)
	
	fire_rate_timer.one_shot = true
	fire_rate_timer.autostart = false
	reload_timer.one_shot = true
	reload_timer.autostart = false
	
	player_cb = owner
	entities_container = get_tree().root.find_child("EntitiesContainer", true, false) 
	
func _process(_delta: float) -> void:
	if not is_setuped:
		return
	
	if gun_data.fire_mode == gun_data.FireMode.SEMI:
		if Input.is_action_just_pressed("fire"):
			_fire()
	elif gun_data.fire_mode == gun_data.FireMode.AUTO:
		if Input.is_action_pressed("fire"):
			_fire()
	
	if Input.is_action_just_pressed("reload"):
		_reload()
	
	var dir_to_mouse: Vector2 = player_cb.global_position.direction_to(get_global_mouse_position())
	var is_facing_right: bool = Vector2.RIGHT.dot(dir_to_mouse) >= 0
	gun_sprite.flip_v = not is_facing_right
	
	look_at(get_global_mouse_position())
	
func _on_fire_rate_timer_timeout() -> void:
	can_fire = true
	
func _on_reload_timer_timeout() -> void:
	crnt_ammo_in_mag = gun_data.magazine_size
	SignalBus.ammo_changed_sig.emit(crnt_ammo_in_mag)
	is_reloading = false
	
func _setup(data: GunData, ammo_in_mag: int = -1) -> void:
	gun_data = data
	
	if not gun_data:
		push_warning("gun_data is null!")
		return
	
	_setup_stats(ammo_in_mag)
	_setup_visuals()
	_setup_muzzle()
	_setup_timers()
	
	is_setuped = true
	
func _setup_stats(ammo_in_mag: int) -> void:
	if ammo_in_mag == -1:
		crnt_ammo_in_mag = gun_data.magazine_size
	else:
		crnt_ammo_in_mag = ammo_in_mag
	
func _setup_visuals() -> void:
	if not gun_data.texture:
		push_warning("gun_data.texture is null")
		return
	
	gun_sprite.texture = gun_data.texture
	gun_sprite.scale = gun_data.sprite_scale
	
func _setup_muzzle() -> void:
	muzzle.position = gun_data.muzzle_position

func _setup_timers() -> void:
	fire_rate_timer.wait_time = gun_data.fire_rate
	reload_timer.wait_time = gun_data.reload_speed

func _fire() -> void:
	if not can_fire or is_reloading:
		return
	
	if crnt_ammo_in_mag <= 0:
		_dry_fire()
		return
			
	if not gun_data.fire_sfx:
		push_warning("gun_data.fire_sfx is null") 
	else:
		audio_player.stream = gun_data.fire_sfx
		audio_player.play()
	
	for pellet in range(gun_data.pellet_count):
		var random_offset = randf_range(-gun_data.spread_angle / 2, gun_data.spread_angle / 2)
		var radians_offset = deg_to_rad(random_offset)
	
		_spawn_bullet(radians_offset)
	
	crnt_ammo_in_mag -= 1
	SignalBus.ammo_changed_sig.emit(crnt_ammo_in_mag)
	can_fire = false
	fire_rate_timer.start()
	
func _dry_fire() -> void:
	if not gun_data.dry_fire_sfx:
		push_warning("gun_data.dry_fire_sfx is null") 
	else:
		audio_player.stream = gun_data.dry_fire_sfx
		audio_player.play()
	
	can_fire = false
	fire_rate_timer.start()
	
func _spawn_bullet(offset: float) -> void:
	if not gun_data.bullet_data.bullet_scene:
		push_warning("gun_data.bullet_data.bullet_scene is null")
		return
		
	var bullet: Bullet = gun_data.bullet_data.bullet_scene.instantiate()
	
	if not entities_container:
		push_warning("entities_container is null")
		return
	
	entities_container.add_child(bullet)
	
	bullet.global_position = muzzle.global_position
	bullet.global_rotation = muzzle.global_rotation + offset
	bullet.setup(gun_data.bullet_data)

func _reload() -> void:
	if is_reloading or crnt_ammo_in_mag == gun_data.magazine_size:
		return 
	
	if not gun_data.reload_sfx:
		push_warning("gun_data.reload_sfx is null")
	else:
		audio_player.stream = gun_data.reload_sfx
		audio_player.play()
	
	is_reloading = true
	reload_timer.start()

func _swap_gun(data: GunData, ammo_in_mag: int) -> void:
	SignalBus.spawn_dropped_gun_sig.emit(gun_data, crnt_ammo_in_mag, player_cb.global_position)
	
	_setup(data, ammo_in_mag)
	SignalBus.ammo_changed_sig.emit(crnt_ammo_in_mag)
