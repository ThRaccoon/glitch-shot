class_name EnemySpawner extends Node

enum EnemyMinionType { MELEE, RANGE }
enum EnemyEliteId { BIG_DEMON, BIG_ZOMBIE, OGRE }

@export var entities_container: Node2D

var minion_scene_registry: Dictionary[EnemyMinionType, String] = {
	EnemyMinionType.MELEE : "uid://cql5ysvp1rysf",
	EnemyMinionType.RANGE : "uid://bbqtbdm05nh71"
}

var minion_resource_registry: Dictionary[EnemyMinionType, Array] = {
	EnemyMinionType.MELEE : [
		"uid://bi5x1sb8paks6",
		"uid://bgk8p87tnc8l1",
		"uid://cpergo8uwh33i",
		"uid://b3pu3egg0n2lb",
		"uid://cninythw5j0tr",
		"uid://4su5y5db78l0",
		"uid://c1dvd1mpyyo8g",
		"uid://b0ye4phv622x0",
		"uid://b88l2kehix3vc",
		"uid://blludqdvweuom",
		"uid://ie7uco3436gc",
		"uid://bv1m46rbdp2on"
	],
	EnemyMinionType.RANGE : [
		"uid://b0vhaso0xcjb2",
		"uid://botuw5lw3npd0",
		"uid://dm885i6t3yhbb",
		"uid://bc1s7irfi0l25"
	]
}

var elite_scene_registry: Dictionary[EnemyEliteId, String] = {
	EnemyEliteId.BIG_DEMON : "",
	EnemyEliteId.BIG_ZOMBIE : "",
	EnemyEliteId.OGRE : ""
}

var elite_resource_registry: Dictionary[EnemyEliteId, String] = {
	EnemyEliteId.BIG_DEMON : "",
	EnemyEliteId.BIG_ZOMBIE : "",
	EnemyEliteId.OGRE : ""
}
