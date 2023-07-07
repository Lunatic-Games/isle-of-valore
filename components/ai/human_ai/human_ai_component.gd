class_name HumanAIComponent
extends NavigationAgent2D


enum AIState {
	IDLE,
	GOING_TO_RESOURCE,
	COLLECTING_RESOURCE,
	RETURNING
}

const N_TREES_TO_RANDOMLY_CHOOSE_FROM: int = 3

var state: AIState = AIState.IDLE
var resource_harvest_target: Structure


func update():
	match state:
		AIState.IDLE:
			target_closest_tree()
		AIState.GOING_TO_RESOURCE:
			check_for_arriving_at_resource()
		AIState.COLLECTING_RESOURCE:
			check_for_resource_harvested()


func target_closest_tree():
	var trees: Array[Node] = GlobalGameState.game.island.tree_container.get_children()
	if trees.is_empty():
		return
	
	var current_position: Vector2 = get_parent().global_position
	trees.sort_custom(
		func(a: Node2D, b: Node2D):
			var a_distance_squared: float = a.global_position.distance_squared_to(current_position)
			var b_distance_squared: float = b.global_position.distance_squared_to(current_position)
			return a_distance_squared < b_distance_squared
	)
	
	var chosen_tree: Structure = trees.slice(0, N_TREES_TO_RANDOMLY_CHOOSE_FROM).pick_random()
	target_position = chosen_tree.global_position
	resource_harvest_target = chosen_tree
	state = AIState.GOING_TO_RESOURCE


func check_for_arriving_at_resource():
	if resource_harvest_target == null:
		state = AIState.IDLE
		return
	
	if is_target_reached():
		state = AIState.COLLECTING_RESOURCE


func check_for_resource_harvested():
	if resource_harvest_target != null:
		return
