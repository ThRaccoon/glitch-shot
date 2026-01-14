class_name GunData extends Resource

enum FireMode { SEMI, AUTO }
enum GunType { PISTOL, SHOTGUN, SMG, RIFLE, SNIPER }

@export_group("Stats")
@export var fire_mode: FireMode
@export var fire_rate: float
@export var reload_speed: float
@export var magazine_size: int

@export_group("Bullet")
@export var bullet_data: BulletData
@export var pellet_count: int
@export var spread_angle: float

@export_group("Visuals")
@export var texture: Texture2D
@export var texture_outlined: Texture2D

@export_group("SFX")
@export var fire_sfx: AudioStream
@export var dry_fire_sfx: AudioStream
@export var reload_sfx: AudioStream

@export_group("Offsets")
@export var sprite_offset: Vector2
@export var sprite_scale: Vector2
@export var muzzle_position: Vector2
