class_name BaseEnemyData extends Resource

@export_group("Stats")
@export var health: float
@export var max_health: float
@export var damage: float
@export var attack_speed: float
@export var move_speed: float
@export var stopping_distance: float = 15.0

@export_group("Visuals")
@export var animations: SpriteFrames

@export_group("Collider")
@export var collider_size: Vector2
@export var collider_pos: Vector2
