class_name Animal
extends Unit

@export var max_healths: Array[int] = [20, 40, 60]

var current_tier: int = 1

func update_tier(new_tier) -> void:
	current_tier = new_tier
	max_health = max_healths[current_tier-1]
	health = max_health
