extends Area2D

@export var audio_player: AudioStreamPlayer2D
@export var explosion_sfx: AudioStream

func _on_fuse_timer_timeout() -> void:
	var bodies = get_overlapping_bodies()
	var areas = get_overlapping_areas()

	var targets = bodies + areas

	for target in targets:
		var health_comp = target.find_child("HealthComponent", true, false) as HealthComponent
		if health_comp:
			health_comp.take_damage(5)
	
	visible = false
	
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	
	audio_player.stream = explosion_sfx
	audio_player.play()
	
	await audio_player.finished
	
	queue_free()
