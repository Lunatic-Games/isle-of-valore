extends Node2D

const INFUSE_COOLDOWN: float = 7.0

var can_infuse: bool = true

func _ready() -> void:
	GlobalGameState.infuse_controller = self

func start_cooldown():
	get_tree().create_timer(INFUSE_COOLDOWN).connect("timeout", ready_infuse)
	can_infuse = false

func ready_infuse():
	can_infuse = true
