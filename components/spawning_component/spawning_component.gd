class_name SpawningComponent
extends Node2D


@export var unit_to_spawn: PackedScene
@export_range(0.0, 60.0, 0.1, "or_greater") var time_until_spawn: float = 10.0

@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	assert(unit_to_spawn != null, "Unit to spawn not specified")
	
	spawn_timer.wait_time = time_until_spawn
	spawn_timer.timeout.connect(spawn_unit)
	spawn_timer.start()


func spawn_unit() -> void:
	var unit: Unit = unit_to_spawn.instantiate()
	unit.global_position = global_position
	print("Spawn: ", str(unit))
