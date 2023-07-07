class_name Game
extends Node2D


@onready var island: Island = $Island


func _ready() -> void:
	randomize()
	
	GlobalGameState.game = self
