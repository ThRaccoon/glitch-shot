class_name LootData extends Resource

enum LootType { BOMB, HP_FLASK_BIG, HP_FLASK_SMALL }

@export_group("Stats")
@export var loot_type: LootType

@export_group("Visuals")
@export var texture: Texture2D

@export_group("SFX")
@export var pickup_sfx: AudioStream

@export_group("Offsets")
@export var sprite_scale: Vector2
