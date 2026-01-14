class_name DroppedGun extends Area2D

@export var gun_sprite: Sprite2D
@export var interaction_label: Label

var gun_data: GunData
var crnt_ammo_in_mag: int

var can_swap: bool

func _ready() -> void:
	interaction_label.visible = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("swap"):
		if can_swap:
			SignalBus.swap_gun_sig.emit(gun_data, crnt_ammo_in_mag)
			
			queue_free()

func _on_body_entered(_body: Node2D) -> void:
	can_swap = true
	interaction_label.visible = true
	
func _on_body_exited(_body: Node2D) -> void:
	can_swap = false
	interaction_label.visible = false

func setup(data: GunData, ammo_in_mag: int = 0) -> void:
	gun_data = data
	crnt_ammo_in_mag = ammo_in_mag
	gun_sprite.texture = gun_data.texture
	gun_sprite.scale = gun_data.sprite_scale
