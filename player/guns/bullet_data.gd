class_name BulletData extends Resource

@export_group("Scene")
@export var bullet_scene: PackedScene

@export_group("Stats")
@export var damage: float
@export var speed: float
@export var lifetime: float = 3.0

@export_group("Visuals")
@export var color: Color = Color(255, 200, 0, 255)
@export var length: float = 10.0
@export var thickness: float = 1.0
