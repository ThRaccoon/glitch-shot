class_name HeroData extends Resource

enum HeroAbilityType { STUN, SPRINT, BLOCK, FEAR, BLINK }

@export_group("Stats")
@export var health: float
@export var max_health: float
@export var move_speed: float
@export var max_bombs: int

@export_group("Ability")
@export var ability_type: HeroAbilityType
@export var ability_scene: PackedScene
@export var ability_cooldown: float

@export_group("Visuals")
@export var animations: SpriteFrames

@export_group("SFX")
@export var hurt_sfx: AudioStream
@export var death_sfx: AudioStream
@export var ability_sfx: AudioStream

@export_group("Collider")
@export var collider_size: Vector2
@export var collider_pos: Vector2
