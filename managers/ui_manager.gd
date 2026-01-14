class_name UIManager extends Node

enum MenuType { MAIN_MENU, HERO_SELECTION }

@export var menus_container: Control
@export var huds_container: Control

var menu_uid_registry: Dictionary[MenuType, String] = {
	MenuType.MAIN_MENU : "uid://de0x2l5dpsnw4",
	MenuType.HERO_SELECTION : "uid://dkm852tqgdfpn"
}

var active_menus: Dictionary[MenuType, Control] = {}

func _ready() -> void:
	SignalBus.open_menu_sig.connect(open_menu)
	SignalBus.show_menu_sig.connect(show_menu)
	SignalBus.hide_menu_sig.connect(hide_menu)
	SignalBus.close_menu_sig.connect(close_menu)
	SignalBus.close_all_menus_sig.connect(close_all_menus)
	
	open_menu(MenuType.MAIN_MENU)

func open_menu(type: MenuType) -> void:
	if not menu_uid_registry.has(type):
		push_warning("menu_uid_registry does not contain menu from type %s" % type)
		return
	
	if active_menus.has(type):
		return
	
	var menu_rsrc: PackedScene = load(menu_uid_registry[type]) 
	var new_menu: Control = menu_rsrc.instantiate()
	add_child(new_menu)
	active_menus[type] = new_menu
		
func show_menu(type: MenuType) -> void:
	if not active_menus.has(type):
		push_warning("active_menus does not contain menu from type %s" % type)
		return
	
	active_menus[type].visible = true
	
func hide_menu(type: MenuType) -> void:
	if not active_menus.has(type):
		push_warning("active_menus does not contain menu from type %s" % type)
		return
	
	active_menus[type].visible = false
	
func close_menu(type: MenuType) -> void:
	if not active_menus.has(type):
		push_warning("active_menus does not contain menu from type %s" % type)
		return
	
	active_menus[type].queue_free()
	active_menus.erase(type)

func close_all_menus() -> void:
	for menu in active_menus:
		close_menu(menu)
