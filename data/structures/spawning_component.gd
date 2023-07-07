extends Node2D

class_name SpawningComponent

@export var unit_to_spawn: Unit
@export var time_until_spawn: float

func _ready() -> void:
	get_tree().create_timer(time_until_spawn).connect("timeout", spawn_unit)

func spawn_unit() -> void:
	var unit = unit_to_spawn.instance()
	unit.position = position
	get_tree().create_timer(time_until_spawn).connect("timeout", spawn_unit)
