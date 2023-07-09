class_name Human
extends Unit


const MOVE_SPEED: float = 200
const TIME_TO_HARVEST: float = 1.0

const MAX_WOOD_HELD: int = 2
const MAX_FOOD_HELD: int = 2

var amount_wood_held: int = 0
var amount_food_held: int = 0
var last_tree_targeted: TreeStructure = null

@onready var animation_player = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var ai: AITreeComponent = $HumanAITreeComponent
@onready var structure_sight_range: Area2D = $StructureSightRange


func _physics_process(_delta: float) -> void:
	ai.update()
	
	if ai.is_navigation_finished():
		return
	
	var next_location: Vector2 = ai.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_location)
	ai.velocity = direction * MOVE_SPEED
	
	move_and_slide()


func _on_human_ai_tree_component_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	if abs(velocity.x) > 10.0:
		sprite.flip_h = velocity.x > 0.0
