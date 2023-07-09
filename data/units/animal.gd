class_name Animal
extends Unit

const MEAT_PARTICLES: PackedScene = preload("res://data/particles/meat_explosion.tscn")

@export var move_speed: float = 200.0
@export var meat_on_death: int = 1
@export var max_healths: Array[int] = [20, 40, 60]
@export var max_damages: Array[int] = [6, 14, 22]
@export var ai_tree_component: AITreeComponent
@export var sprite: Sprite2D = null
@export var animation_player: AnimationPlayer = null

@onready var attack_damage: int = max_damages[0]


var current_tier: int = 1


func _ready():
	if ai_tree_component != null:
		ai_tree_component.velocity_computed.connect(_on_ai_tree_component_velocity_computed)


func update_tier(new_tier) -> void:
	current_tier = new_tier
	max_health = max_healths[current_tier-1]
	health = max_health
	attack_damage = max_damages[current_tier-1]


func _physics_process(_delta: float) -> void:
	if ai_tree_component == null:
		return
	
	ai_tree_component.update()
	
	if ai_tree_component.is_navigation_finished():
		return
	
	var next_location: Vector2 = ai_tree_component.get_next_path_position()
	var direction: Vector2 = global_position.direction_to(next_location)
	ai_tree_component.velocity = direction * move_speed
	
	move_and_slide()


func die():
	var particles = MEAT_PARTICLES.instantiate()
	GlobalGameState.game.add_child(particles)
	particles.global_position = global_position


func _on_ai_tree_component_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity
	if sprite != null and abs(velocity.x) > 10.0:
		sprite.flip_h = velocity.x > 0.0
