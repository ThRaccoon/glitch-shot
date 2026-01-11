extends Button

func _on_pressed() -> void:
	SignalBus.show_menu_sig.emit(UIManager.MenuType.MAIN_MENU)
	SignalBus.close_menu_sig.emit(UIManager.MenuType.HERO_SELECTION)
