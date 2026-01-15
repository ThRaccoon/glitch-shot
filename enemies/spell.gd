class_name Spell extends Area2D

@export var spell_sprite: Sprite2D

var spell_dmg: float
var spell_speed: float
var spell_dir: Vector2

var is_setuped

func _physics_process(delta: float) -> void:
	if not is_setuped:
		return

	position += spell_speed * spell_dir * delta

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.health_comp:
			body.health_comp.take_damage(spell_dmg)
			queue_free()
	else:
		queue_free()

func setup(dmg: float, speed: float, lifetime: float, dir: Vector2, spell_texture: Texture2D) -> void:
	spell_dmg = dmg
	spell_speed = speed
	spell_dir = dir
	spell_sprite.texture = spell_texture

	is_setuped = true
	
	get_tree().create_timer(lifetime).timeout.connect(queue_free)
