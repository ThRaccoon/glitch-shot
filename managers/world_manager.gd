class_name WorldManager extends Node

@export_group("Managers")
@export var _lvl_mngr: LevelManager 

@export_group("Spawners")
@export var _player_spawner: PlayerSpawner
@export var _enemy_spawner: EnemySpawner
@export var _destructible_spawner: DestructibleSpawner
@export var _loot_spawner: LootSpawner

var _pending_hero_data: HeroData

func _ready() -> void:
	_lvl_mngr.lvl_loaded_sig.connect(_on_level_ready)

func prepare_world(hero_data: HeroData) -> void:
	_pending_hero_data = hero_data
	_lvl_mngr.load_random_level()

func _on_level_ready() -> void:	
	var player_spn_pts = _lvl_mngr.type_to_spn_pts[_lvl_mngr.SpawnPointType.PLAYER]
	_player_spawner.spawn_player(_pending_hero_data, player_spn_pts)
	_pending_hero_data = null
