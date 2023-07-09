class_name Player
extends Unit


const MOVE_SPEED: float = 200
const SQUIRREL_DEN_SCENE: PackedScene = preload("res://data/structures/squirrel_den/squirrel_den.tscn")
const WOLF_DEN_SCENE: PackedScene = preload("res://data/structures/wolf_den/wolf_den.tscn")
const BEAR_DEN_SCENE: PackedScene = preload("res://data/structures/bear_den/bear_den.tscn")

var interactables: Array[Area2D] = []
var currently_interactive: Area2D
var ability_map: Dictionary = {
	0: spawn_wolf_den,
	1: spawn_squirrel_den,
	2: spawn_bear_den
}
var wolf_den_cost: int = 40
var bear_den_cost: int = 90
var squirrel_den_cost: int = 65

@onready var infuse_particles: GPUParticles2D = $InfuseParticles


func _ready() -> void:
	GlobalGameState.infuse_controller.connect("ready_to_infuse", activate_infuse_particles)
	GlobalGameState.infuse_controller.connect("infused", deactivate_infuse_particles)
	

func _physics_process(delta: float) -> void:
	var movement := Vector2()
	
	if Input.is_action_pressed("move_up"):
		movement.y -= 1
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_down"):
		movement.y += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	#if Input.is_action_just_pressed("perform_ability"):
	#	perform_ability()
	if Input.is_action_just_pressed("interact"):
		handle_interact()
	#if Input.is_action_just_pressed("cycle_ability_left"):
	#	GlobalGameState.HUD.cycle_ability(-1)
	#if Input.is_action_just_pressed("cycle_ability_right"):
	#	GlobalGameState.HUD.cycle_ability(1)
	
	if movement.x != 0 || movement.y != 0 && !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("walking")
	elif movement.x == 0 and movement.y == 0:
		$AnimationPlayer.play("stop")
	
	if movement.x > 0:
		$Sprite2D.flip_h = true
	if movement.x < 0:
		$Sprite2D.flip_h = false
	
	velocity = movement.normalized() * MOVE_SPEED
	move_and_slide()


func perform_ability() -> void:
	var ability_index = GlobalGameState.HUD.get_current_ability_index()
	print(ability_index)
	ability_map[ability_index].call()


func handle_interact() -> void:
	if !currently_interactive:
		return
	currently_interactive.interact()


func _on_interactable_searcher_area_entered(area: Area2D) -> void:
	if area is InteractComponent:
		interactables.append(area)
		choose_currently_interactive()


func _on_interactable_searcher_area_exited(area: Area2D) -> void:
	if area is InteractComponent:
		interactables.remove_at(interactables.find(area))
		choose_currently_interactive()


func choose_currently_interactive():
	var closest_area: Area2D
	
	for area in interactables:
		if !closest_area || global_position.distance_to(area.global_position) < global_position.distance_to(closest_area.global_position):
			closest_area = area
	
	if currently_interactive && currently_interactive != closest_area:
		currently_interactive.hide_interactive()
	
	currently_interactive = closest_area
	if currently_interactive:
		currently_interactive.show_interactive()


func spawn_wolf_den() -> void:
	if GlobalGameState.HUD.currency < wolf_den_cost:
		return
	
	var den: Den = WOLF_DEN_SCENE.instantiate()
	den.global_position = Vector2(global_position.x, global_position.y - 50)
	GlobalGameState.game.add_child(den)
	GlobalGameState.HUD.update_currency(-wolf_den_cost)


func spawn_squirrel_den() -> void:
	if GlobalGameState.HUD.currency < squirrel_den_cost:
		return
	
	var squirrel_den: Den = SQUIRREL_DEN_SCENE.instantiate()
	squirrel_den.global_position = Vector2(global_position.x, global_position.y - 50)
	GlobalGameState.game.add_child(squirrel_den)
	GlobalGameState.HUD.update_currency(-squirrel_den_cost)


func spawn_bear_den() -> void:
	if GlobalGameState.HUD.currency < bear_den_cost:
		return
		
	var bear_den: Den = BEAR_DEN_SCENE.instantiate()
	bear_den.global_position = Vector2(global_position.x, global_position.y - 50)
	GlobalGameState.game.add_child(bear_den)
	GlobalGameState.HUD.update_currency(-bear_den_cost)

func activate_infuse_particles() -> void:
	infuse_particles.emitting = true

func deactivate_infuse_particles() -> void:
	infuse_particles.emitting = false
