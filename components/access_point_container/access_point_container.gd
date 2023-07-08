class_name AccessPointContainer
extends Node2D


func has_unreserved_account_point() -> bool:
	for point in get_children():
		if point.reserved_by_unit == null:
			return true
	return false


func get_closest_unreserved_access_point(to_position: Vector2) -> AccessPoint:
	assert(get_child_count() > 0, "No access points!")
	
	var closest_access_point: AccessPoint = null
	var closest_distance_squared: float = INF
	
	for access_point in get_children():
		if access_point.reserved_by_unit != null:
			continue
		
		var distance_squared: float = access_point.global_position.distance_squared_to(to_position)
		if distance_squared < closest_distance_squared:
			closest_access_point = access_point
			closest_distance_squared = distance_squared
	
	return closest_access_point
