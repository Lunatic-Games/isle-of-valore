class_name Structure
extends StaticBody2D


@export var max_health = 100

@onready var health = max_health
@onready var access_points: AccessPointContainer = $AccessPointContainer


func damage(amount: int):
	health -= amount
