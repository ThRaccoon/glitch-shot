extends Node

@warning_ignore_start("unused_signal")
# Game related
signal hero_selected_sig(data: HeroData)
signal load_initial_gun_sig(data: GunData)

# Gun swap related
signal swap_gun_sig(data: GunData, mag_count: int)
signal spawn_dropped_gun_sig(data: GunData, mag_count: int, pos: Vector2)

# Drop Gun / Loot related
signal spawn_rand_gun_sig(pos: Vector2)
signal spawn_rand_loot_sig(pos: Vector2)

# DEBUG related
signal spawn_gun_sig(data: GunData, mag_count: int, pos: Vector2)
signal spawn_loot_sig(data: LootData, pos: Vector2)

# Menu related
signal open_menu_sig(key: UIManager.MenuType)
signal show_menu_sig(key: UIManager.MenuType)
signal hide_menu_sig(key: UIManager.MenuType)
signal close_menu_sig(key: UIManager.MenuType)
signal close_all_menus_sig
@warning_ignore_restore("unused_signal")
