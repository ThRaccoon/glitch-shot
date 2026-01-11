class_name LevelManager extends Node

enum LevelId { LIMINAL_REACH }
enum SpawnPointType { PLAYER, MINION, ELITE, DESTRUCTIBLE, TREASURE }

signal lvl_loaded_sig() 

const TYPE_TO_SPN_PT_CNTR_NAMES: Dictionary[SpawnPointType, String] = {
	SpawnPointType.PLAYER: "PlayerSpawnPoints",
	SpawnPointType.MINION: "MinionSpawnPoints",
	SpawnPointType.ELITE: "EliteSpawnPoints",
	SpawnPointType.DESTRUCTIBLE: "DestructibleSpawnPoints",
	SpawnPointType.TREASURE: "TreasureSpawnPoints"
}

var type_to_spn_pts: Dictionary[SpawnPointType, Array] = {}

var lvl_registry: Dictionary[LevelId, String] = {
	LevelId.LIMINAL_REACH : "uid://cknam78ta6oro"
}

var crnt_lvl: Node2D
var crnt_lvl_spn_pts_cntr: Node

func load_level_by_id(id: LevelId) -> void:
	if crnt_lvl:
		crnt_lvl.queue_free()
		
	if not lvl_registry.has(id):
		push_error("Level registry does not contain level with id %s" % id)
		return
		
	var lvl_uid: String = lvl_registry[id]
	var lvl_scene: PackedScene = load(lvl_uid)
	
	if not lvl_scene:
		push_error("Failed to load level scene with uid %s" % lvl_uid)
		return
	
	crnt_lvl = lvl_scene.instantiate()
	crnt_lvl_spn_pts_cntr = crnt_lvl.find_child("SpawnPointsContainer")
	
	self.add_child(crnt_lvl)
	
	_cache_current_level_spawn_points()
	
	lvl_loaded_sig.emit()
	
func load_random_level() -> void:
	if crnt_lvl:
		crnt_lvl.queue_free()
	
	var lvl_keys: Array = lvl_registry.keys()
	
	if lvl_keys.is_empty():
		push_error("Level registry is empty")
		return
	
	var lvl_uid: String = lvl_registry[lvl_keys.pick_random()]
	var lvl_scene: PackedScene = load(lvl_uid)
	
	if not lvl_scene:
		push_error("Failed to load level scene with uid %s" % lvl_uid)
		return
	
	crnt_lvl = lvl_scene.instantiate()
	crnt_lvl_spn_pts_cntr = crnt_lvl.find_child("SpawnPointsContainer")
	
	self.add_child(crnt_lvl)
	
	_cache_current_level_spawn_points()
	
	lvl_loaded_sig.emit()

func _cache_current_level_spawn_points() -> void:
	type_to_spn_pts.clear()
	
	if not crnt_lvl_spn_pts_cntr:
		push_error("'SpawnPointsContainer' node not found in %s scene tree" % crnt_lvl.name)
		
	for type in SpawnPointType.values():
		type_to_spn_pts[type] = []
		
		var node_name = TYPE_TO_SPN_PT_CNTR_NAMES[type]
		var sub_spn_pts_cntr = crnt_lvl_spn_pts_cntr.find_child(node_name)
		
		if not sub_spn_pts_cntr:
			push_error("Failed to find %s node in %s scene tree" % [node_name, crnt_lvl.name])
		
		for spn_pt in sub_spn_pts_cntr.get_children():
			if spn_pt is Marker2D:
				type_to_spn_pts[type].append(spn_pt.global_position)
