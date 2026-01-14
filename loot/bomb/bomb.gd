extends Area2D

@export var audio_player: AudioStreamPlayer2D
@export var explosion_sfx: AudioStream

func _on_fuse_timer_timeout() -> void:
	var targets = get_overlapping_bodies()

	for target in targets:
		var health_comp = target.find_child("HealthComponent", true, false) as HealthComponent
		if health_comp:
			health_comp.take_damage(5)
	
	visible = false
	monitoring = false	
	monitorable = false
	
	audio_player.stream = explosion_sfx
	audio_player.play()
	
	await audio_player.finished
	
	queue_free()
