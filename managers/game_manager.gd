class_name GameManager extends Node

@export var world_mngr: WorldManager
@export var ui_mngr: UIManager
 
func _ready() -> void:
	SignalBus.hero_selected_sig.connect(_on_game_started)
	
func _on_game_started(data: HeroData) -> void:
	world_mngr.prepare_world(data, LevelManager.LevelId.TheDungeon)
