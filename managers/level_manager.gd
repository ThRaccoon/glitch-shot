class_name LevelManager extends Node

enum LevelId { TheDungeon }
enum SpawnPointType { PLAYER, MINION, ELITE, DESTRUCTIBLE, TREASURE }

signal level_loaded_sig()

var _level_scenes_map: Dictionary[LevelId, String] = {
	LevelId.TheDungeon : "uid://cm3g1mnh42vxo"
}

var crnt_level: Node2D

func load_level(level_id: LevelId) -> void:
	if crnt_level:
		crnt_level.queue_free()
		
	if not _level_scenes_map.has(level_id):
		push_error("Failed to find level with id: ", level_id)
		return
		
	var level_path: String = _level_scenes_map[level_id]
	var level_scene: PackedScene = load(level_path)
	
	if level_scene:
		crnt_level = level_scene.instantiate()
		self.add_child(crnt_level)
		level_loaded_sig.emit()
	else: 
		push_error("Failed to load level scene with path: ", level_path)
		
func get_current_level_spawn_points() -> Dictionary[SpawnPointType, Array]:
		var level_spawn_points_map: Dictionary[SpawnPointType, Array] = {}
		
		for type in SpawnPointType.values():
			level_spawn_points_map[type] = []
		
		var spawn_points_container = crnt_level.get_node_or_null("SpawnPointsContainer")
		if not spawn_points_container:
			push_error("Failed to find 'SpawnPointsContainer' node in current level: ", \
				crnt_level.name)
			return level_spawn_points_map
		
		for marker in spawn_points_container.get_children():
			if marker is Marker2D:
				var node_name = marker.name.to_lower()
				var pos = marker.global_position
		
				if node_name.begins_with("player"):
					level_spawn_points_map[SpawnPointType.PLAYER].append(pos)
				elif node_name.begins_with("minion"):
					level_spawn_points_map[SpawnPointType.MINION].append(pos)
				elif node_name.begins_with("elite"):
					level_spawn_points_map[SpawnPointType.ELITE].append(pos)
				elif node_name.begins_with("destructible"):
					level_spawn_points_map[SpawnPointType.DESTRUCTIBLE].append(pos)
				elif node_name.begins_with("treasure"):
					level_spawn_points_map[SpawnPointType.TREASURE].append(pos)
		
		return level_spawn_points_map
