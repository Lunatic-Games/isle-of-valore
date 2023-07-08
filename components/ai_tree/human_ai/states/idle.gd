extends AIState


@export var n_trees_to_randomly_pick_from: int = 3


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("idle")


func update():
	var human: Human = unit as Human
	if human.amount_wood_held >= human.MAX_WOOD_HELD:
		ai_tree.transition_to("returning_to_hq")
		return
	
	if human.target == null:
		target_new_tree()
	
	if human.target == null:
		return
	
	ai_tree.transition_to("going_to_harvest")


func target_new_tree():
	var trees: Array[TreeStructure] = []
	trees.append_array(GlobalGameState.game.island.tree_container.get_children())
	if trees.is_empty():
		return
	
	var current_position: Vector2 = unit.global_position
	trees.sort_custom(
		func(a: Node2D, b: Node2D):
			var a_distance_squared: float = a.global_position.distance_squared_to(current_position)
			var b_distance_squared: float = b.global_position.distance_squared_to(current_position)
			return a_distance_squared < b_distance_squared
	)
	
	var human: Human = unit as Human
	var possible_trees: Array[TreeStructure] = []
	for tree in trees:
		if tree.unit_reserving_harvest != null or tree.remaining_wood <= 0:
			continue
		
		possible_trees.append(tree)
		if possible_trees.size() >= n_trees_to_randomly_pick_from:
			break
	
	var chosen_tree: TreeStructure = possible_trees.pick_random()
	human.target = chosen_tree
	chosen_tree.unit_reserving_harvest = human
