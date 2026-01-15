extends Button
 
@export var info: TextEdit
@export var hero_data: HeroData

func _on_pressed() -> void:
	SignalBus.hero_selected_sig.emit(hero_data)
	SignalBus.open_menu_sig.emit(UIManager.MenuType.IN_GAME_HUD)
	SignalBus.close_menu_sig.emit(UIManager.MenuType.MAIN_MENU)
	SignalBus.close_menu_sig.emit(UIManager.MenuType.HERO_SELECTION)
	
func _on_mouse_entered() -> void:
	if hero_data:
		var ability_type: String = HeroData.HeroAbilityType.keys()[hero_data.ability_type]
		
		info.text = """
		Health:   {health}
		Max Health:   {max_health}
		Move Speed:   {move_speed}
		Max Bombs:   {max_bombs}
		Ability Type:   {ability_type}
		Ability Cooldown: {ability_cooldown}s
		""".format({
			"health": hero_data.health,
			"max_health": hero_data.max_health,
			"move_speed": hero_data.move_speed,
			"max_bombs" : hero_data.max_bombs,
			"ability_type": ability_type,
			"ability_cooldown": hero_data.ability_cooldown
		})

func _on_mouse_exited() -> void:
	info.text = ""
