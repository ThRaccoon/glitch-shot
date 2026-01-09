class_name PlayerSpawner extends Node

var player_scene_uid: String = "uid://c1gyjs0ddhhqy"
var player: Player

func spawn_player(data: HeroData):
	var player_scene: PackedScene = load(player_scene_uid)
	
	if player_scene:
		player = player_scene.instantiate()
		player.set_hero_data(data)
		
		self.add_child(player)
	else:
		push_error("Failed to load player scene with uid: ", player_scene_uid)
