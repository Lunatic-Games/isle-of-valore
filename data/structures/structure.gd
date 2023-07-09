class_name Structure
extends StaticBody2D


@export var max_health = 100

@onready var health = max_health
@onready var access_points: AccessPointContainer = $AccessPointContainer
@onready var health_bar: HealthBar = $HealthBar


func damage(amount: int):
	health = max(health - amount, 0)
	health_bar.update(float(health) / float(max_health))
	if health <= 0:
		queue_free()


func heal(amount: int):
	health = min(health + amount, max_health)
	health_bar.update(float(health) / float(max_health))
