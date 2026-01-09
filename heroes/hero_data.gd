class_name HeroData extends Resource

@export_group("Stats")
@export var health: float
@export var max_health: float
@export var damage: float
@export var move_speed: float

@export_group("Ability")
@export var ability_type: Enums.HeroAbilityType
@export var ability_scene: PackedScene
@export var ability_cooldown: float

@export_group("Visuals")
@export var animations: SpriteFrames

@export_group("Sounds")
@export var hurt_sound: AudioStream
@export var death_sound: AudioStream
@export var ability_sound: AudioStream

@export_group("Hitbox")
@export var hitbox_size: Vector2
@export var hitbox_pos: Vector2
