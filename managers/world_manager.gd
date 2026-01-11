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
	lvl_mngr.lvl_loaded_sig.connect(_on_level_ready)

func prepare_world(hero_data: HeroData) -> void:
	pending_hero_data = hero_data
	lvl_mngr.load_random_level()

func _on_level_ready() -> void:	
	var player_spn_pts = lvl_mngr.type_to_spn_pts[lvl_mngr.SpawnPointType.PLAYER]
	player_spawner.spawn_player(pending_hero_data, player_spn_pts)
	pending_hero_data = null
