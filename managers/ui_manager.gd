class_name UIManager extends CanvasLayer

enum MenuType { MAIN_MENU, HERO_SELECTION }

var menu_registry: Dictionary[MenuType, String] = {
	MenuType.MAIN_MENU : "uid://de0x2l5dpsnw4",
	MenuType.HERO_SELECTION : "uid://dkm852tqgdfpn"
}

var active_menus: Dictionary[MenuType, Control] = {}

# Menus
@onready var menus_container: Control = $MenusContainer

# Huds
@onready var huds_container: Control = $HudsContainer

func _ready() -> void:
	SignalBus.open_menu_sig.connect(open_menu)
	SignalBus.show_menu_sig.connect(show_menu)
	SignalBus.hide_menu_sig.connect(hide_menu)
	SignalBus.close_menu_sig.connect(close_menu)
	SignalBus.close_all_menus_sig.connect(close_all_menus)
	
	open_menu(MenuType.MAIN_MENU)

func open_menu(key: MenuType) -> void:
	if not menu_registry.has(key):
		push_warning("Menu key not found in registry: ", key)
		return
	
	if active_menus.has(key):
		return
	
	var menu_rsrc: PackedScene = load(menu_registry[key]) 
	var new_menu: Control = menu_rsrc.instantiate()
	add_child(new_menu)
	active_menus[key] = new_menu
		
func show_menu(key: MenuType) -> void:
	if not active_menus.has(key):
		push_warning("Menu key not found in active menus: ", key)
		return
	
	active_menus[key].visible = true
	
func hide_menu(key: MenuType) -> void:
	if not active_menus.has(key):
		push_warning("Menu key not found in active menus: ", key)
		return
	
	active_menus[key].visible = false
	
func close_menu(key: MenuType) -> void:
	if not active_menus.has(key):
		push_warning("Menu key not found in active menus: ", key)
		return
	
	active_menus[key].queue_free()
	active_menus.erase(key)

func close_all_menus() -> void:
	for key in active_menus:
		close_menu(key)
