extends Node2D

const INFUSE_COOLDOWN: float = 7.0

var cost_to_infuse = 10
var can_infuse: bool = true
var infused_trees: int = 0

signal ready_to_infuse

func _ready() -> void:
	GlobalGameState.infuse_controller = self

func start_cooldown():
	get_tree().create_timer(INFUSE_COOLDOWN).connect("timeout", ready_infuse)
	can_infuse = false
	infused_trees += 1
	cost_to_infuse += infused_trees * 10

func ready_infuse():
	can_infuse = true
	emit_signal("ready_to_infuse")
