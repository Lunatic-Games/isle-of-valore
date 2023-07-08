extends AIState


@export var n_tree_to_randomly_pick_from: int = 3


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("idle")


func update():
	var human: Human = unit as Human
	if human.amount_wood_held >= human.MAX_WOOD_HELD:
		ai_tree.transition_to("returning_to_base")
		return
	
	var trees: Array[Node] = GlobalGameState.game.island.tree_container.get_children()
	if trees.is_empty():
		return
	
	var current_position: Vector2 = unit.global_position
	trees.sort_custom(
		func(a: Node2D, b: Node2D):
			var a_distance_squared: float = a.global_position.distance_squared_to(current_position)
			var b_distance_squared: float = b.global_position.distance_squared_to(current_position)
			return a_distance_squared < b_distance_squared
	)
	
	var chosen_tree: TreeStructure = trees.slice(0, n_tree_to_randomly_pick_from).pick_random()
	human.targetted_resource_structure = chosen_tree
	
	ai_tree.transition_to("going_to_resource")
