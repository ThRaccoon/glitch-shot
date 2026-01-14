class_name DestructibleData extends Resource

enum DestructibleType { CHEST, CRATE }

@export_group("Stats")
@export var drop_type: DestructibleType
@export_range(0.0, 1.0) var drop_chance: float
@export var health: float

@export_group("Visuals")
@export var textures: Array[Texture2D]

@export_group("Collider")
@export var collider_size: Vector2
@export var collider_pos: Vector2
