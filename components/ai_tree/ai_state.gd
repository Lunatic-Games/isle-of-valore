class_name AIState
extends Node


@export var state_name: String = ""
@export var priority_level: int = 1
@export var override_target_distance: bool = false
@export var target_distance: float = 0

@onready var ai_tree: AITreeComponent = get_parent()
@onready var unit: Unit = get_parent().get_parent()


func on_enter(_previous_state: AIState = null) -> void:
	pass


func update() -> void:
	pass


func on_exit(_next_state: AIState = null) -> void:
	pass


func passive_update() -> void:
	pass
