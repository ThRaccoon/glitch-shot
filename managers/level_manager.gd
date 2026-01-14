class_name LevelManager extends Node

enum LevelId { LIMINAL_REACH }
enum SpawnPointType { PLAYER, MINION, ELITE, DESTRUCTIBLE, TREASURE }

signal lvl_loaded_sig() 

const SPAWN_POINT_CONTAINER_NAMES: Dictionary[SpawnPointType, String] = {
	SpawnPointType.PLAYER: "PlayerSpawnPoints",
	SpawnPointType.MINION: "MinionSpawnPoints",
	SpawnPointType.ELITE: "EliteSpawnPoints",
	SpawnPointType.DESTRUCTIBLE: "DestructibleSpawnPoints",
	SpawnPointType.TREASURE: "TreasureSpawnPoints"
}

var spawn_points: Dictionary[SpawnPointType, Array] = {}

var lvl_uid_registry: Dictionary[LevelId, String] = {
	LevelId.LIMINAL_REACH : "uid://cknam78ta6oro"
}

var crnt_lvl: Node2D
var crnt_lvl_spawn_points_container: Node

func load_level_by_id(id: LevelId) -> void:
	if not lvl_uid_registry.has(id):
		push_warning("lvl_uid_registry does not contain level with id %s" % id)
		return
	
	_load_level(lvl_uid_registry[id])
	 
func load_random_level() -> void:
	var lvl_keys: Array = lvl_uid_registry.keys()
	
	if lvl_keys.is_empty():
		push_warning("lvl_uid_registry is empty")
		return
	
	_load_level(lvl_uid_registry[lvl_keys.pick_random()])
	
func _load_level(uid: String) -> void:
	if crnt_lvl:
		crnt_lvl.queue_free()

	var lvl_scene: PackedScene = load(uid)
	if not lvl_scene:
		push_warning("Failed to load level scene with uid %s" % uid)
		return
	
	crnt_lvl = lvl_scene.instantiate()
	
	self.add_child(crnt_lvl)
	
	_cache_current_level_spawn_points()
	
	lvl_loaded_sig.emit()

func _cache_current_level_spawn_points() -> void:
	spawn_points.clear()
	
	crnt_lvl_spawn_points_container = crnt_lvl.find_child("SpawnPointsContainer")
	if not crnt_lvl_spawn_points_container:
		push_warning("SpawnPointsContainer node not found in %s scene tree" % crnt_lvl.name)
		
	for type in SpawnPointType.values():
		spawn_points[type] = []
		
		var node_name = SPAWN_POINT_CONTAINER_NAMES[type]
		var sub_spawn_points_container = crnt_lvl_spawn_points_container.find_child(node_name)
		
		if not sub_spawn_points_container:
			push_warning("Can't find %s node in %s scene tree" % [node_name, crnt_lvl.name])
		
		for spawn_point in sub_spawn_points_container.get_children():
			if spawn_point is Marker2D:
				spawn_points[type].append(spawn_point.global_position)
