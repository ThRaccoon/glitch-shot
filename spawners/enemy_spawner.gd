class_name EnemySpawner extends Node

enum EnemyMinionType { MELEE, RANGE }
enum EnemyEliteId { BIG_DEMON, BIG_ZOMBIE, OGRE }

var minion_scenes: Dictionary[EnemyMinionType, String] = {
	EnemyMinionType.MELEE : "uid://cql5ysvp1rysf",
	EnemyMinionType.RANGE : "uid://bbqtbdm05nh71"
}

var minion_resources: Dictionary[EnemyMinionType, Array] = {
	EnemyMinionType.MELEE : [
		"uid://bi5x1sb8paks6",   # chort
		"uid://bgk8p87tnc8l1",   # goblin
		"uid://cpergo8uwh33i",   # ice_zombie
		"uid://b3pu3egg0n2lb",   # imp
		"uid://cninythw5j0tr",   # masked_orc
		"uid://4su5y5db78l0",    # muddy
		"uid://c1dvd1mpyyo8g",   # orc_warrior
		"uid://b0ye4phv622x0",   # pumpkin_dude
		"uid://b88l2kehix3vc",   # skelet
		"uid://blludqdvweuom",   # swampy
		"uid://ie7uco3436gc",    # tiny_zombie
		"uid://bv1m46rbdp2on"    # zombie
	],
	EnemyMinionType.RANGE : [
		"uid://b0vhaso0xcjb2",   # doc
		"uid://botuw5lw3npd0",   # necromancer
		"uid://dm885i6t3yhbb",   # orc_shaman
		"uid://bc1s7irfi0l25"    # wogol
	]
}

var elite_scenes: Dictionary[EnemyEliteId, String] = {
	EnemyEliteId.BIG_DEMON : "",
	EnemyEliteId.BIG_ZOMBIE : "",
	EnemyEliteId.OGRE : ""
}

var elite_resources: Dictionary[EnemyEliteId, String] = {
	EnemyEliteId.BIG_DEMON : "",
	EnemyEliteId.BIG_ZOMBIE : "",
	EnemyEliteId.OGRE : ""
}
