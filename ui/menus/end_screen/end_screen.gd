extends Control

@export var wave_count_label: Label

func _ready() -> void:
	wave_count_label.text = "WAVES SURVIVED: " + str(SignalBus.crnt_wave_num - 1)
