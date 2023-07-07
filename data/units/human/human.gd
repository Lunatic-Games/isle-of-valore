extends Unit


const MOVE_SPEED: float = 200

@onready var ai: HumanAIComponent = $HumanAIComponent


func _physics_process(_delta: float) -> void:
	if ai.get_navigation_map() == null:
		return
	
	ai.update()
	
	if ai.is_navigation_finished():
		return
	
	var next_location: Vector2 = ai.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_location)
	ai.velocity = direction * MOVE_SPEED
	
	move_and_slide()


func _on_human_ai_component_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
