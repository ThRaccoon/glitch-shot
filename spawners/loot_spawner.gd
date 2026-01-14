class_name LootSpawner extends Node

@export var entities_container: Node2D
@export var dropped_gun_scene: PackedScene
@export var loot_scene: PackedScene

var gun_resource_registry: Dictionary[GunData.GunType, Array] = {
	GunData.GunType.PISTOL : [
		"uid://bayd717ckvw7g",
		"uid://ckfnjnhpy2ivk"
	],
	GunData.GunType.SHOTGUN : [
		"uid://1ntdp1yus4cp",
		"uid://bgds4nvwcm4o0"	
	],
	GunData.GunType.SMG : [
		"uid://cgkcyxdp0hjr7",
		"uid://boa8ysmysytm0"
	],
	GunData.GunType.RIFLE : [
		"uid://dkxjxfy5cnyr1",
		"uid://obwlqpokbvxf"
	],
	GunData.GunType.SNIPER : [
		"uid://ccbrh4a7ggb4s",
		"uid://bcv0f0fv36yl5"
	]
}

var loot_resource_registry: Dictionary[LootData.LootType, String] = {
	LootData.LootType.BOMB : "uid://7a5k4b0bkjp5",
	LootData.LootType.HP_FLASK_BIG : "uid://u2yhcf7jdnk8",
	LootData.LootType.HP_FLASK_SMALL : "uid://b83bx6bxc6lpq"
}

func _ready() -> void:
	SignalBus.spawn_dropped_gun_sig.connect(_spawn_dropped_gun)
	SignalBus.spawn_loot_sig.connect(_spawn_loot)
	
func _spawn_dropped_gun(data: GunData, mag_count: int, pos: Vector2) -> void:
	var dropped_gun = dropped_gun_scene.instantiate() as DroppedGun
	
	entities_container.add_child(dropped_gun)
	
	dropped_gun.global_position = pos
	dropped_gun.setup(data, mag_count)

func get_gun_data_by_uid(uid: String) -> GunData:
	return load(uid) as GunData

func get_random_gun_data_by_type(type: GunData.GunType) -> GunData:
	var uids: Array = gun_resource_registry.get(type, [])
	
	if uids.is_empty():
		push_warning("gun_resource_registry does not contain guns from type %s" % type)
		return null
	
	var random_uid: String = uids.pick_random()
	
	return get_gun_data_by_uid(random_uid)
	
func get_random_gun_data() -> GunData:
	var gun_types: Array = gun_resource_registry.keys()
	
	if gun_types.is_empty():
		push_warning("gun_resource_registry is empty")
		return null
	
	return get_random_gun_data_by_type(gun_types.pick_random())

func _spawn_loot(data: LootData, pos: Vector2):
	var loot = loot_scene.instantiate() as Loot
	
	entities_container.add_child(loot)
	
	loot.global_position = pos
	loot.loot_data = data
	loot.setup(data)
	
func get_loot_data_by_uid(uid: String) -> LootData:
	return load(uid) as LootData
	
func get_random_loot_data_by_type(type: LootData.LootType) -> LootData:
	var uid: String = loot_resource_registry.get(type, "")
	
	if uid == "":
		push_warning("loot_resource_registry does not contain loot from type %s" % type)
		return null
		
	return get_loot_data_by_uid(uid)
	
func get_random_loot_data() -> LootData:
	var loot_types: Array = loot_resource_registry.keys()
	
	if loot_types.is_empty():
		push_warning("loot_resource_registry is empty")
		return null
	
	return get_random_loot_data_by_type(loot_types.pick_random())
