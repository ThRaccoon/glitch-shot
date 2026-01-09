extends Control

func _on_play_btn_pressed() -> void:
	SignalBus.hide_menu_sig.emit(UIManager.MenuType.MAIN_MENU)
	SignalBus.open_menu_sig.emit(UIManager.MenuType.HERO_SELECTION)
	
func _on_exit_btn_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
