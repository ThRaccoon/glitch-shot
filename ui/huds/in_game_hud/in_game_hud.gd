extends Control

@export var wave_msg_label: Label
@export var ammo_label: Label
@export var bomb_label: Label
@export var hp_label: Label
 
func _ready() -> void:
	_update_ammo(SignalBus.ammo)
	_update_bombs(0, SignalBus.max_bombs)
	_update_hp(SignalBus.hp, SignalBus.max_hp)
	
	_on_wave_started(1)
	
	SignalBus.wave_started_sig.connect(_on_wave_started)
	SignalBus.wave_finished_sig.connect(_on_wave_finished)
	
	SignalBus.ammo_changed_sig.connect(_update_ammo)
	SignalBus.bombs_changed_sig.connect(_update_bombs)
	SignalBus.hp_changed_sig.connect(_update_hp)
	
func _on_wave_started(wave_num: int) -> void:
	wave_msg_label.text = "WAVE " + str(wave_num) + " BEGUN"
	_fade_label()

func _on_wave_finished(wave_num: int) -> void:
	wave_msg_label.text = "WAVE " + str(wave_num) + " CLEAR"
	_fade_label()
	
func _fade_label() -> void:
	wave_msg_label.modulate.a = 1.0
	
	var tween = create_tween()
	tween.tween_property(wave_msg_label, "modulate:a", 0.0, 0.5).set_delay(1.5)
	
func _update_ammo(current: int) -> void:
	ammo_label.text = str(current) + " / ∞"

func _update_bombs(current: int, max_bombs: int) -> void:
	bomb_label.text = str(current) + " / " + str(max_bombs)

func _update_hp(current: float, max_hp: float) -> void:
	hp_label.text = str(current) + " / " + str(max_hp)
