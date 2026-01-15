class_name WaveManager extends Node

signal wave_completed(wave_num: int)

@export var lvl_mngr: LevelManager
@export var enemy_spawner: EnemySpawner
@export var destructible_spawner: DestructibleSpawner

var current_wave: int = 0
var enemies_alive: int = 0

func _ready() -> void:
	SignalBus.enemy_died_sig.connect(_on_enemy_died)

func start_next_wave() -> void:
	current_wave += 1
	if current_wave % 3 == 0:
		spawn_elite_wave()
	else:
		spawn_normal_wave()

func spawn_normal_wave() -> void:
	var spawn_points = lvl_mngr.spawn_points[lvl_mngr.SpawnPointType.MINION]
	var amount = 1 + (current_wave * 2) 
	
	for i in range(amount):
		var pos = spawn_points.pick_random()
		var type = EnemySpawner.EnemyType.values().pick_random()
		var uids = enemy_spawner.minion_resource_registry[type]
		
		enemy_spawner.spawn_enemy(type, uids.pick_random(), pos)
		enemies_alive += 1

func spawn_elite_wave() -> void:
	var spawn_points = lvl_mngr.spawn_points[lvl_mngr.SpawnPointType.ELITE]
	var elite_id = EnemySpawner.EnemyEliteId.values().pick_random()
	var elite_uid = enemy_spawner.elite_resource_registry[elite_id]
	
	enemy_spawner.spawn_enemy(EnemySpawner.EnemyType.MELEE, elite_uid, spawn_points.pick_random())
	enemies_alive += 1

func _on_enemy_died(_pos: Vector2 = Vector2.ZERO) -> void:
	enemies_alive -= 1
	if enemies_alive <= 0:
		_handle_wave_end()

func _handle_wave_end() -> void:
	if current_wave % 3 == 0:
		var treasure_points = lvl_mngr.spawn_points[lvl_mngr.SpawnPointType.TREASURE]
		if not treasure_points.is_empty():
			destructible_spawner.spawn_destructible(
				DestructibleData.DestructibleType.CHEST, 
				treasure_points.pick_random()
			)
	else:
		var crate_points = lvl_mngr.spawn_points[lvl_mngr.SpawnPointType.DESTRUCTIBLE]
		if not crate_points.is_empty():
			for i in range(2):
				destructible_spawner.spawn_destructible(
					DestructibleData.DestructibleType.CRATE, 
					crate_points.pick_random()
				)
	
	wave_completed.emit(current_wave)
	
	await get_tree().create_timer(3.0).timeout
	start_next_wave()
