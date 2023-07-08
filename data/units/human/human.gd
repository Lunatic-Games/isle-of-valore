class_name Human
extends Unit


const MOVE_SPEED: float = 200
const TIME_TO_HARVEST: float = 1.0

const MAX_WOOD_HELD: int = 2
const MAX_FOOD_HELD: int = 2

var amount_wood_held: int = 0
var amount_food_held: int = 0

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
