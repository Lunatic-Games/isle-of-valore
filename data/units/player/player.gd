class_name Player
extends Unit


const MOVE_SPEED: float = 240
const SQUIRREL_DEN_SCENE: PackedScene = preload("res://data/structures/squirrel_den/squirrel_den.tscn")
const WOLF_DEN_SCENE: PackedScene = preload("res://data/structures/wolf_den/wolf_den.tscn")
const BEAR_DEN_SCENE: PackedScene = preload("res://data/structures/bear_den/bear_den.tscn")

var interactables: Array[Area2D] = []
var currently_interactive: Area2D

@onready var infuse_particles: GPUParticles2D = $InfuseParticles


func _ready() -> void:
	GlobalGameState.player = self
	GlobalGameState.infuse_controller.connect("ready_to_infuse", activate_infuse_particles)
	GlobalGameState.infuse_controller.connect("infused", deactivate_infuse_particles)
	

func _physics_process(_delta: float) -> void:
	if $AnimationPlayer.current_animation == "casting":
		return
	
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
	
	if Input.is_action_just_pressed("interact"):
		handle_interact()
	
	velocity = movement.normalized() * MOVE_SPEED
	move_and_slide()


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


func activate_infuse_particles() -> void:
	infuse_particles.emitting = true


func deactivate_infuse_particles() -> void:
	infuse_particles.emitting = false


func do_casting_animation() -> void:
	$AnimationPlayer.play("casting")
