class_name Bullet extends Area2D

@export var tracer: Line2D
@export var collider: CollisionShape2D
@export var lifetime_timer: Timer

var bullet_data: BulletData

var is_setuped: bool

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	position += Vector2.RIGHT.rotated(rotation) * bullet_data.speed * delta

func _on_body_entered(body: Node2D) -> void:
	var health_comp: HealthComponent = body.find_child("HealthComponent")
	
	if health_comp:
		health_comp.take_damage(bullet_data.damage)
	
	queue_free()

func setup(data: BulletData) -> void:
	bullet_data = data
	
	if not bullet_data:
		push_error("bullet_data is null!")
		return
	
	_setup_tracer()
	_setup_collider()
	_setup_timers()
	
	is_setuped = true
	
func _setup_tracer() -> void:
	tracer.add_point(Vector2.ZERO)
	tracer.add_point(Vector2(-bullet_data.length, 0))
	tracer.width = bullet_data.thickness
	tracer.default_color = bullet_data.color
	
func _setup_collider() -> void:
	if not collider.shape is RectangleShape2D:
		push_error("Bullets are ment to work with RectangleShape2D")
		return
	
	var collider_shape = collider.shape as RectangleShape2D
	collider_shape.size = Vector2(bullet_data.length, bullet_data.thickness)
	collider.position.x = -bullet_data.length / 2
	
func _setup_timers() -> void:
	lifetime_timer.wait_time = bullet_data.lifetime
	lifetime_timer.start()
	lifetime_timer.timeout.connect(queue_free)
