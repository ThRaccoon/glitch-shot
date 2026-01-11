class_name PlayerSpawner extends Node

const _PLAYER_SCENE_UID: String = "uid://c1gyjs0ddhhqy"

var _player: Player

func spawn_player(data: HeroData, spn_pts: Array = []) -> void:
	var player_scene: PackedScene = load(_PLAYER_SCENE_UID)
	
	if not player_scene:
		push_error("Faild to load player scene with uid: ", _PLAYER_SCENE_UID)
		return
		
	_player = player_scene.instantiate()
	_player.set_hero_data(data)
	
	if not spn_pts.is_empty():
		var random_pos = spn_pts.pick_random()
		_player.global_position = random_pos
 
	self.add_child(_player)
