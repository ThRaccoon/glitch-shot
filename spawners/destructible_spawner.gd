class_name DestructibleSpawner extends Node

@export var entities_container: Node2D
@export var destructible_scene: PackedScene

var destructible_resource_registry: Dictionary[DestructibleData.DestructibleType, String] = {
	DestructibleData.DestructibleType.CHEST : "uid://ckgbdn7domx6j",
	DestructibleData.DestructibleType.CRATE : "uid://bmc3q0my27vcr"
}

func spawn_destructible(type: DestructibleData.DestructibleType, pos: Vector2) -> void:
	var uid = destructible_resource_registry.get(type, "")
	if uid == "":
		push_warning("destructible_resource_registry does not contain destructible from type %s" % type)
		return
		
	var data = load(uid) as DestructibleData
	if not data:
		push_warning("data is null")
		return
		
	var obj = destructible_scene.instantiate() as Destructible
	entities_container.add_child(obj)
	obj.global_position = pos
	obj.setup(data)
