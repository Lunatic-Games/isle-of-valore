class_name Player
extends Unit


const MOVE_SPEED: float = 200

@onready var den_scene: PackedScene = preload("res://data/structures/den/den.tscn")

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
	
	move_and_collide(movement.normalized() * MOVE_SPEED * delta)

func perform_ability() -> void:
	# For now just spawning a den
	var den: Structure = den_scene.instantiate()
	den.global_position = Vector2(global_position.x, global_position.y - 50)
	GlobalGameState.game.add_child(den)
