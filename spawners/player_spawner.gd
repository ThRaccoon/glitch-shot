class_name PlayerSpawner extends Node

const PLAYER_SCENE_UID: String = "uid://c1gyjs0ddhhqy"

var player: Player

func spawn_player(data: HeroData, spn_pts: Array = []) -> void:
	var player_scene: PackedScene = load(PLAYER_SCENE_UID)
	
	if not player_scene:
		push_error("Faild to load player scene with uid: ", PLAYER_SCENE_UID)
		return
		
	player = player_scene.instantiate()
	player.set_hero_data(data)
	
	if not spn_pts.is_empty():
		var random_pos = spn_pts.pick_random()
		player.global_position = random_pos
 
	self.add_child(player)
