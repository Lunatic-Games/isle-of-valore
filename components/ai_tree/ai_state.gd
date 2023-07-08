class_name AIState
extends Node


@export var state_name: String = ""

@onready var ai_tree: AITreeComponent = get_parent()
@onready var unit: Unit = get_parent().get_parent()


func on_enter(_previous_state: AIState = null):
	pass


func update():
	pass


func on_exit(_next_state: AIState = null):
	pass
