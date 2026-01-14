class_name PlayerSpawner extends Node

signal player_loaded_sig

const PLAYER_SCENE_UID: String = "uid://c1gyjs0ddhhqy"

@export var entities_container: Node2D

var player: Player

func spawn_player(data: HeroData, spn_pts: Array = []) -> void:
	var player_scene: PackedScene = load(PLAYER_SCENE_UID)
	
	if not player_scene:
		push_warning("Failed to load player scene with uid %s" % PLAYER_SCENE_UID)
		return
		
	player = player_scene.instantiate()
	player.set_hero_data(data)
	
	if not spn_pts.is_empty():
		var random_pos = spn_pts.pick_random()
		player.global_position = random_pos
 	
	player.ready.connect(_on_player_ready)
	
	entities_container.add_child(player)

func _on_player_ready() -> void:
	player_loaded_sig.emit()
