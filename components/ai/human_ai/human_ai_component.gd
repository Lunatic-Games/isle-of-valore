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

@onready var human: Human = get_parent()
@onready var harvest_timer: Timer = $HarvestTimer


func _ready() -> void:
	harvest_timer.wait_time = human.TIME_TO_HARVEST


func update():
	match state:
		AIState.IDLE:
			idle_logic()
		AIState.GOING_TO_RESOURCE:
			going_to_resource_logic()
		AIState.COLLECTING_RESOURCE:
			collecting_resource_logic()
		AIState.RETURNING:
			returning_logic()


func idle_logic():
	if human.amount_wood_held >= human.MAX_WOOD_HELD:
		_return_to_hq_for_dropoff()
		return
	
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
	
	var chosen_tree: TreeStructure = trees.slice(0, N_TREES_TO_RANDOMLY_CHOOSE_FROM).pick_random()
	target_position = chosen_tree.harvest_location.global_position
	resource_harvest_target = chosen_tree
	state = AIState.GOING_TO_RESOURCE


func going_to_resource_logic():
	if resource_harvest_target == null:
		state = AIState.IDLE
		return
	
	if is_target_reached():
		state = AIState.COLLECTING_RESOURCE
		target_position = human.global_position


func collecting_resource_logic():
	if resource_harvest_target == null:
		return
	
	if harvest_timer.is_stopped():
		harvest_timer.start()


func returning_logic() -> void:
	if is_target_reached():
		GlobalGameState.game.island.hq.held_wood += human.amount_wood_held
		human.amount_wood_held = 0
		state = AIState.IDLE


func _on_harvest_timer_timeout() -> void:
	if resource_harvest_target == null:
		state = AIState.IDLE
		harvest_timer.stop()
		return
	
	var tree: TreeStructure = resource_harvest_target as TreeStructure
	if tree:
		if tree.remaining_wood > 0:
			tree.remaining_wood -= 1
			human.amount_wood_held += 1
		
		if tree.remaining_wood == 0:
			tree.queue_free()
			state = AIState.IDLE
			harvest_timer.stop()
		
		if human.amount_wood_held >= human.MAX_WOOD_HELD:
			harvest_timer.stop()
			_return_to_hq_for_dropoff()


func _return_to_hq_for_dropoff():
	target_position = GlobalGameState.game.island.hq.drop_off_location.global_position
	state = AIState.RETURNING
