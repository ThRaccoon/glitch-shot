class_name WorldManager extends Node

@export var level_mngr: LevelManager 
@export var player_spawner: PlayerSpawner
@export var enemies_spawner: EnemiesSpawner
@export var destructibles_spawner: DestructiblesSpawner
@export var loot_spawner: LootSpawner

var _pending_hero_data: HeroData

func _ready() -> void:
	level_mngr.level_loaded_sig.connect(_on_level_ready)

func prepare_world(hero_data: HeroData, level_id: LevelManager.LevelId) -> void:
	_pending_hero_data = hero_data
	level_mngr.load_level(level_id)

func _on_level_ready() -> void:
	player_spawner.spawn_player(_pending_hero_data)
	_pending_hero_data = null
