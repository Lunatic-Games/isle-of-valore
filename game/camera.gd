extends Camera2D


@export var follow_target: Node2D
@export var follow_enabled: bool = false


func _physics_process(_delta: float) -> void:
	if follow_enabled == false:
		return
	
	if follow_target:
		global_position = follow_target.global_position
