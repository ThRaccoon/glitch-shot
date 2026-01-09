extends Node

@warning_ignore_start("unused_signal")
# Game related
signal hero_selected_sig(data: HeroData)
 
# Menu related
signal open_menu_sig(key: UIManager.MenuType)
signal show_menu_sig(key: UIManager.MenuType)
signal hide_menu_sig(key: UIManager.MenuType)
signal close_menu_sig(key: UIManager.MenuType)
signal close_all_menus_sig
@warning_ignore_restore("unused_signal")
