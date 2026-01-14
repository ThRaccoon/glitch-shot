class_name Loot extends Node

@export var loot_sprite: Sprite2D

var loot_data: LootData 

var is_setuped: bool

func _on_body_entered(body: Node2D) -> void:
	var player = body as Player 
	if player:
		_attempt_pickup(player)

func setup(data: LootData) -> void:
	loot_data = data
	
	if not loot_data:
		push_error("loot_data is null!")
		return
	
	_setup_visuals()
	
	is_setuped = true
	
func _setup_visuals() -> void:
	loot_sprite.texture = loot_data.texture
	loot_sprite.scale = loot_data.sprite_scale
	
func _attempt_pickup(player: Player) -> void:
	match loot_data.loot_type:
		LootData.LootType.BOMB:
			if player.crnt_bomb_count < player.hero_data.max_bombs:
				player.crnt_bomb_count += 1
				queue_free()
		
		LootData.LootType.HP_FLASK_BIG:
			if player.health_comp.current_health < player.health_comp.max_health:
				player.health_comp.heal(1)
		
		LootData.LootType.HP_FLASK_SMALL:
			if player.health_comp.current_health < player.health_comp.max_health:
				player.health_comp.heal(0.5)
