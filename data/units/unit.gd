class_name Unit
extends CharacterBody2D


@export var max_health = 20

@onready var health = max_health


func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()
