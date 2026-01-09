class_name RangeEnemy extends BaseEnemy

var range_enemy_data: RangeEnemyData

var attack_range: float

# override
func _ready() -> void:
	range_enemy_data = base_enemy_data as RangeEnemyData
	
	super()

# override
func _process(delta: float) -> void:
	super(delta)

# override
func _on_health_component_health_changed_cmd(current_hp: Variant, max_hp: Variant) -> void:
	super(current_hp, max_hp)

# override
func _on_health_component_health_depleted_cmd() -> void:
	super()

# override
func _setup_stats() -> void:
	super()
	
	attack_range = range_enemy_data.attack_range
	
# override
func _setup_visuals() -> void:
	super()

# override
func _setup_sounds() -> void:
	super()

# override
func _setup_collider() -> void:
	super()

# override
func _setup_components() -> void:
	super()
