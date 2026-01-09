extends Button

func _on_pressed() -> void:
	SignalBus.show_menu_cmd.emit(UIManager.MenuType.MAIN_MENU)
	SignalBus.close_menu_cmd.emit(UIManager.MenuType.HERO_SELECTION)
