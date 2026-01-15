class_name WorldManager extends Node

@export_group("Managers")
@export var lvl_mngr: LevelManager 
@export var wave_mngr: WaveManager

@export_group("Spawners")
@export var player_spawner: PlayerSpawner
@export var enemy_spawner: EnemySpawner
@export var destructible_spawner: DestructibleSpawner
@export var loot_spawner: LootSpawner

var pending_hero_data: HeroData

func _ready() -> void:
	lvl_mngr.lvl_loaded_sig.connect(_on_level_loaded)
	player_spawner.player_loaded_sig.connect(_on_player_loaded)
	
func prepare_world(hero_data: HeroData) -> void:
	pending_hero_data = hero_data
	lvl_mngr.load_random_level()

func _on_level_loaded() -> void:
	var player_spawn_points: Array = lvl_mngr.spawn_points[lvl_mngr.SpawnPointType.PLAYER]
	player_spawner.spawn_player(pending_hero_data, player_spawn_points)
	
	# Set  initial player hp / bombs
	SignalBus.hp = pending_hero_data.health
	SignalBus.max_hp = pending_hero_data.max_health
	SignalBus.max_bombs = pending_hero_data.max_bombs
	
	pending_hero_data = null
	
func _on_player_loaded() -> void:
	var initial_gun_data = loot_spawner.get_rand_gun_data_by_type(GunData.GunType.PISTOL)
	SignalBus.load_initial_gun_sig.emit(initial_gun_data)
	
	# Set  initial player ammo
	SignalBus.ammo = initial_gun_data.magazine_size
	
	enemy_spawner.set_player(player_spawner.player)
	
	wave_mngr.start_next_wave()
