class_name AITreeComponent
extends NavigationAgent2D


@export var start_state: AIState

var current_state: AIState = null

@onready var unit: Unit = get_parent()


func _ready() -> void:
	assert(start_state != null, "Start state not set")
	assert(unit != null, "Parent of AI tree component is not a unit!")
	await get_tree().process_frame
	transition_to(start_state.state_name)


func update():
	if current_state:
		current_state.update()


func transition_to(state_name: String):
	if current_state and current_state.state_name == state_name:
		return
	
	for child in get_children():
		var ai_state: AIState = child as AIState
		if ai_state == null:
			continue
		
		if ai_state.state_name == state_name:
			if current_state != null:
				current_state.on_exit(ai_state)
			
			var previous_state: AIState = current_state
			current_state = ai_state
			current_state.on_enter(previous_state)
			return
	
	assert(false, "Uh oh, could not find state with name: '" + state_name + "'")


func get_current_state_name() -> String:
	if current_state:
		return current_state.state_name
	return ""
