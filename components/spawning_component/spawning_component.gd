class_name SpawningComponent
extends Node2D


@export var unit_to_spawn: PackedScene
@export_range(0.0, 60.0, 0.1, "or_greater") var time_until_spawn: float = 10.0
@export var costs_to_spawn: Array[int] = [0, 0, 0]

@onready var spawn_timer: Timer = $SpawnTimer
@onready var currency_animator: AnimationPlayer = get_parent().find_child("CurrencyAnimator")


func _ready() -> void:
	assert(unit_to_spawn != null, "Unit to spawn not specified")
	
	await(get_tree().process_frame)
	spawn_unit()
	spawn_timer.wait_time = time_until_spawn
	spawn_timer.timeout.connect(spawn_unit)
	spawn_timer.start()


func spawn_unit() -> void:
	var true_spawn_cost = costs_to_spawn[get_parent().current_tier-1]
	if GlobalGameState.game == null || GlobalGameState.HUD.currency < (true_spawn_cost):
		return
	
	var unit: Unit = unit_to_spawn.instantiate()
	unit.global_position = global_position
	GlobalGameState.game.add_child(unit)
	unit.update_tier(get_parent().current_tier) # Sets the animal tier to the tier of the den
	GlobalGameState.HUD.update_currency(-true_spawn_cost)
	
	if currency_animator:
		get_parent().currency_label.text = "-" + str(true_spawn_cost)
		currency_animator.play("show_cost")
