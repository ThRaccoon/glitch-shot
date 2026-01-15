class_name EnemySpawner extends Node

enum EnemyType { MELEE, RANGE }
enum EnemyEliteId { BIG_DEMON, BIG_ZOMBIE, OGRE }

@export var entities_container: Node2D
@export var player_ref: Player

var minion_scene_registry: Dictionary[EnemyType, String] = {
	EnemyType.MELEE : "uid://cql5ysvp1rysf",
	EnemyType.RANGE : "uid://bbqtbdm05nh71"
}

var minion_resource_registry: Dictionary[EnemyType, Array] = {
	EnemyType.MELEE : [
		"uid://bi5x1sb8paks6",
		"uid://cninythw5j0tr",
		"uid://4su5y5db78l0", 
		"uid://b0ye4phv622x0", 
		"uid://blludqdvweuom", 
	],
	EnemyType.RANGE : [
		"uid://b0vhaso0xcjb2",
		"uid://botuw5lw3npd0",
		"uid://dm885i6t3yhbb",
		"uid://bc1s7irfi0l25"
	]
}

var elite_resource_registry: Dictionary[EnemyEliteId, String] = {
	EnemyEliteId.BIG_DEMON : "uid://bpt1f3k3d2hfr",
	EnemyEliteId.BIG_ZOMBIE : "uid://bmo27ivl4bqhs",
	EnemyEliteId.OGRE : "uid://bl4sm21jw4fps"
}

func set_player(player: Player) -> void:
	player_ref = player

func spawn_enemy(type: EnemyType, uid: String, pos: Vector2) -> void:
	var scene_path = minion_scene_registry.get(type)
	if not scene_path:
		push_warning("minion_scene_registry does not contain scene from type %s" % type)
		return
		
	var enemy_scene = load(scene_path) as PackedScene
	
	var enemy_instance = enemy_scene.instantiate() as BaseEnemy
	if not enemy_instance:
		push_warning("enemy_instance is null")
		return
		
	var enemy_data = load(uid) as BaseEnemyData
	
	enemy_instance.set_enemy_data(enemy_data)
	enemy_instance.player_ref = player_ref
	enemy_instance.global_position = pos
	entities_container.add_child(enemy_instance)
