class_name MeleeEnemy extends BaseEnemy

var melee_enemy_data: MeleeEnemyData

# override
func _ready() -> void:
	melee_enemy_data = base_enemy_data as MeleeEnemyData
	
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
