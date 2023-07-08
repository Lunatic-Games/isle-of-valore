class_name AIState
extends Node2D


@export var state_name: String = ""
@export var priority_level: int = 1

@onready var ai_tree: AITreeComponent = get_parent()
@onready var unit: Unit = get_parent().get_parent()


func on_enter(_previous_state: AIState = null):
	pass


func update():
	pass


func on_exit(_next_state: AIState = null):
	pass


func should_auto_transition() -> bool:
	return false
