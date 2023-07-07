class_name Player
extends Unit


const MOVE_SPEED: float = 200

var interactables: Array[Area2D] = []
var currently_interactive: Area2D

@onready var den_scene: PackedScene = preload("res://data/structures/den/den.tscn")
@onready var wolf_den_scene: PackedScene = preload("res://data/structures/wolf_den/wolf_den.tscn")

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
	if Input.is_action_just_pressed("perform_ability"):
		perform_ability()
	if Input.is_action_just_pressed("interact"):
		handle_interact()
	
	if movement.x != 0 || movement.y != 0 && !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("walking")
	elif movement.x == 0 and movement.y == 0:
		$AnimationPlayer.play("stop")
	
	if movement.x > 0:
		$Sprite2D.flip_h = true
	if movement.x < 0:
		$Sprite2D.flip_h = false
	
	move_and_collide(movement.normalized() * MOVE_SPEED * delta)


func perform_ability() -> void:
	# Check the active ability
	# Trigger the associated effect
	
	# For now just spawning a den
	spawn_wolf_den()

func handle_interact() -> void:
	if !currently_interactive:
		return
	currently_interactive.interact()


func _on_interactable_searcher_area_entered(area: Area2D) -> void:
	interactables.append(area)
	choose_currently_interactive()


func _on_interactable_searcher_area_exited(area: Area2D) -> void:
	interactables.remove_at(interactables.find(area))
	choose_currently_interactive()


func choose_currently_interactive():
	var closest_area: Area2D
	
	for area in interactables:
		if !closest_area || global_position.distance_to(area.global_position) < global_position.distance_to(closest_area.global_position):
			closest_area = area
	
	currently_interactive = closest_area


func spawn_squirrel_den() -> void:
	var den: Structure = den_scene.instantiate()
	den.global_position = Vector2(global_position.x, global_position.y - 50)
	GlobalGameState.game.add_child(den)

func spawn_wolf_den() -> void:
	var den: Structure = wolf_den_scene.instantiate()
	den.global_position = Vector2(global_position.x, global_position.y - 50)
	GlobalGameState.game.add_child(den)
