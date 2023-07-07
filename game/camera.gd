extends Camera2D


@export var follow_target: Node2D


func _physics_process(_delta: float) -> void:
	if follow_target:
		global_position = follow_target.global_position
