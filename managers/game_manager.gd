class_name GameManager extends Node

@export_group("Managers")
@export var _world_mngr: WorldManager
@export var _ui_mngr: UIManager
 
func _ready() -> void:
	SignalBus.hero_selected_sig.connect(_on_game_started)
	
func _on_game_started(data: HeroData) -> void:
	_world_mngr.prepare_world(data)
