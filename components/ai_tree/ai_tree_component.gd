class_name AITreeComponent
extends NavigationAgent2D


@export var start_state: AIState

var current_state: AIState = null
var all_states: Dictionary = {}  # state name : state

@onready var default_target_distance: float = target_desired_distance
@onready var unit: Unit = get_parent()


func _ready() -> void:
	assert(start_state != null, "Start state not set")
	assert(unit != null, "Parent of AI tree component is not a unit!")
	await get_tree().process_frame
	
	for child in get_children():
		var ai_state: AIState = child as AIState
		if ai_state == null:
			continue
			
		assert(all_states.has(ai_state.state_name) == false, "Duplicate state names!")
		all_states[ai_state.state_name] = ai_state
	
	transition_to(start_state.state_name)


func update():
	for state_name in all_states:
		all_states[state_name].passive_update()
	
	if current_state != null:
		current_state.update()


func transition_to(state_name: String):
	assert(all_states.has(state_name), "Uh oh, could not find state with name: '" + state_name + "'")
	
	if current_state and current_state.state_name == state_name:
		return
	
	var next_state: AIState = all_states[state_name]
	if current_state != null:
		current_state.on_exit(next_state)
	
	var previous_state: AIState = current_state
	current_state = next_state
	if current_state.override_target_distance:
		target_desired_distance = current_state.target_distance
	else:
		target_desired_distance = default_target_distance
	current_state.on_enter(previous_state)


func get_current_state_name() -> String:
	if current_state:
		return current_state.state_name
	return ""
