class_name Structure
extends StaticBody2D


@export var max_health = 100

@onready var health = max_health
@onready var interact_point_container: Node2D = $AIInteractPoints


func get_closest_interact_position(to_position: Vector2) -> Vector2:
	var closest_position: Vector2 = interact_point_container.global_position
	var closest_distance_squared: float = closest_position.distance_squared_to(to_position)
	for point in interact_point_container.get_children():
		var distance_squared: float = point.global_position.distance_squared_to(to_position)
		if distance_squared < closest_distance_squared:
			closest_position = point.global_position
			closest_distance_squared = distance_squared
	
	return closest_position
