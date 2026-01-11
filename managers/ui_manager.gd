class_name UIManager extends Node

enum MenuType { MAIN_MENU, HERO_SELECTION }

@export var menus_cntr: Control
@export var huds_cntr: Control

var _menu_registry: Dictionary[MenuType, String] = {
	MenuType.MAIN_MENU : "uid://de0x2l5dpsnw4",
	MenuType.HERO_SELECTION : "uid://dkm852tqgdfpn"
}

var _active_menus: Dictionary[MenuType, Control] = {}

func _ready() -> void:
	SignalBus.open_menu_sig.connect(open_menu)
	SignalBus.show_menu_sig.connect(show_menu)
	SignalBus.hide_menu_sig.connect(hide_menu)
	SignalBus.close_menu_sig.connect(close_menu)
	SignalBus.close_all_menus_sig.connect(close_all_menus)
	
	open_menu(MenuType.MAIN_MENU)

func open_menu(key: MenuType) -> void:
	if not _menu_registry.has(key):
		push_warning("Menu key not found in registry: ", key)
		return
	
	if _active_menus.has(key):
		return
	
	var menu_rsrc: PackedScene = load(_menu_registry[key]) 
	var new_menu: Control = menu_rsrc.instantiate()
	add_child(new_menu)
	_active_menus[key] = new_menu
		
func show_menu(key: MenuType) -> void:
	if not _active_menus.has(key):
		push_warning("Menu key not found in active menus: ", key)
		return
	
	_active_menus[key].visible = true
	
func hide_menu(key: MenuType) -> void:
	if not _active_menus.has(key):
		push_warning("Menu key not found in active menus: ", key)
		return
	
	_active_menus[key].visible = false
	
func close_menu(key: MenuType) -> void:
	if not _active_menus.has(key):
		push_warning("Menu key not found in active menus: ", key)
		return
	
	_active_menus[key].queue_free()
	_active_menus.erase(key)

func close_all_menus() -> void:
	for menu in _active_menus:
		close_menu(menu)
