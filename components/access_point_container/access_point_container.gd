class_name AccessPointContainer
extends Node2D


func has_unreserved_access_point() -> bool:
	for point in get_children():
		if point.reserved_by_unit == null:
			return true
	return false


func has_an_access_point() -> bool:
	return get_child_count() > 0


func get_closest_access_point(to_position: Vector2) -> AccessPoint:
	assert(get_child_count() > 0, "No access points!")
	
	var closest_unreserved: AccessPoint = null
	var closest_unreserved_distance_squared: float = INF
	var closest_reserved: AccessPoint = null
	var closest_reserved_distance_squared: float = INF
	
	for access_point in get_children():
		var distance_squared: float = access_point.global_position.distance_squared_to(to_position)
		if access_point.reserved_by_unit == null:
			if distance_squared < closest_unreserved_distance_squared:
				closest_unreserved = access_point
				closest_unreserved_distance_squared = distance_squared
		elif distance_squared < closest_reserved_distance_squared:
			closest_reserved = access_point
			closest_reserved_distance_squared = distance_squared
	
	if closest_unreserved:
		return closest_unreserved
	return closest_reserved
