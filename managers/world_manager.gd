class_name WorldManager extends Node

@export_group("Managers")
@export var lvl_mngr: LevelManager 

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
	pending_hero_data = null
	
func _on_player_loaded() -> void:
	var initial_gun_data = loot_spawner.get_random_gun_data_by_type(GunData.GunType.PISTOL)
	
	SignalBus.load_initial_gun_sig.emit(initial_gun_data)
	SignalBus.spawn_dropped_gun_sig.emit(loot_spawner.get_random_gun_data(), 0, Vector2.ZERO)
	
	SignalBus.spawn_loot_sig.emit(loot_spawner.get_loot_data_by_uid("uid://7a5k4b0bkjp5"), Vector2(100, 100))
