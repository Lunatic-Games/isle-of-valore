extends AIState


@export var n_trees_to_randomly_pick_from: int = 3


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("idle")
	human.clear_target()


func update():
	var human: Human = unit as Human
	var health_ratio = float(human.health) / float(human.max_health)
	if health_ratio < 0.5 and GlobalGameState.game.island.hq.held_food > 0:
		ai_tree.transition_to("going_to_campfire")
		return
	
	if human.amount_wood_held >= human.max_wood_held:
		ai_tree.transition_to("returning_to_hq")
		return
	
	var valid_last_tree_target: bool = is_instance_valid(human.last_tree_targeted)
	valid_last_tree_target = valid_last_tree_target and human.can_target_structure(human.last_tree_targeted)
	valid_last_tree_target = valid_last_tree_target and human.last_tree_targeted.can_be_harvested()
	if valid_last_tree_target:
		human.target_structure(human.last_tree_targeted)
	else:
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
		if is_instance_valid(tree) == false or tree.can_be_harvested() == false:
			continue
		
		if human.can_target_structure(tree) == false:
			continue
		
		possible_trees.append(tree)
		if possible_trees.size() >= n_trees_to_randomly_pick_from:
			break
	
	var chosen_tree: TreeStructure = possible_trees.pick_random()
	human.target_structure(chosen_tree)
	human.last_tree_targeted = chosen_tree
