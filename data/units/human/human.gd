class_name Human
extends Unit


signal died

const MOVE_SPEED: float = 200
const TIME_TO_HARVEST: float = 1.0
const MAX_FOOD_HELD: int = 2

var max_wood_held = 2
var wood_harvested = 1
var attack_damage = 8
var amount_wood_held: int = 0
var amount_food_held: int = 0
var last_tree_targeted: TreeStructure = null

@onready var animation_player = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var ai: AITreeComponent = $HumanAITreeComponent
@onready var structure_sight_range: Area2D = $StructureSightRange
@onready var dialogue: DialogueComponent = $DialogueComponent


func _ready():
	await get_tree().process_frame
	var hq = GlobalGameState.game.island.hq
	hq.connect("axe_upgraded", update_axe_stats)
	hq.connect("armor_upgraded", update_armor_stats)
	hq.connect("spear_upgraded", update_spear_stats)

func _physics_process(_delta: float) -> void:
	ai.update()
	
	if ai.is_navigation_finished():
		return
	
	var next_location: Vector2 = ai.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_location)
	ai.velocity = direction * MOVE_SPEED
	pass
	move_and_slide()


func _on_human_ai_tree_component_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	if abs(velocity.x) > 10.0:
		sprite.flip_h = velocity.x > 0.0


func update_axe_stats():
	max_wood_held += 2
	wood_harvested = 1

func update_armor_stats():
	max_health += 70
	health += 70

func update_spear_stats():
	attack_damage += 10

func die():
	died.emit()
