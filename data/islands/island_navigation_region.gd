extends NavigationRegion2D


func _ready() -> void:
	var temp_navigation_polygon: NavigationPolygon = navigation_polygon
	var collision_polygons: Array[PackedVector2Array] = _get_all_collision_polygons(self)
	for poly in collision_polygons:
		temp_navigation_polygon.add_outline(poly)
	temp_navigation_polygon.make_polygons_from_outlines()
	navigation_polygon = temp_navigation_polygon


func _get_all_collision_polygons(root_node: Node) -> Array[PackedVector2Array]:
	var polygons: Array[PackedVector2Array] = []
	var node_stack: Array[Node] = [root_node]
	
	while !node_stack.is_empty():
		var current_node: Node = node_stack.pop_front()
		node_stack.append_array(current_node.get_children())
		
		if current_node is CollisionPolygon2D:
			var poly_transform: Transform2D = current_node.get_global_transform()
			var poly: PackedVector2Array = current_node.polygon
			polygons.append(poly_transform * poly)
	
	return polygons
