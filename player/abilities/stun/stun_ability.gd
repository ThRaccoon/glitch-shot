extends BaseAbility

@export var target_finder: ShapeCast2D

@export var stun_radius: float
@export var stun_duration: float

# override
func _on_cast() -> void:
	super()
	print("Stun")
