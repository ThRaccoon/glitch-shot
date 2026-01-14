class_name PlayerSpawner extends Node

signal player_loaded_sig

@export var entities_container: Node2D
@export var player_scene: PackedScene

var player: Player

func spawn_player(data: HeroData, spawn_points: Array = []) -> void:
	if not player_scene:
		push_warning("Failed to load player scene")
		return
		
	player = player_scene.instantiate()
	player.set_hero_data(data)
	
	if not spawn_points.is_empty():
		var random_pos = spawn_points.pick_random()
		player.global_position = random_pos
 	
	player.ready.connect(_on_player_ready)
	
	entities_container.add_child(player)

func _on_player_ready() -> void:
	player_loaded_sig.emit()
