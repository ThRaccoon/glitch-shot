extends Control

@export var ammo_label: Label
@export var bomb_label: Label
@export var hp_label: Label
 
func _ready() -> void:
	_update_ammo(SignalBus.ammo)
	_update_bombs(0, SignalBus.max_bombs)
	_update_hp(SignalBus.hp, SignalBus.max_hp)
	
	SignalBus.ammo_changed_sig.connect(_update_ammo)
	SignalBus.bombs_changed_sig.connect(_update_bombs)
	SignalBus.hp_changed_sig.connect(_update_hp)
	
func _update_ammo(current: int) -> void:
	ammo_label.text = str(current) + " / ∞"

func _update_bombs(current: int, max_bombs: int) -> void:
	bomb_label.text = str(current) + " / " + str(max_bombs)

func _update_hp(current: float, max_hp: float) -> void:
	hp_label.text = str(current) + " / " + str(max_hp)
