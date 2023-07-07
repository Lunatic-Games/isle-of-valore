class_name Player
extends Unit


const MOVE_SPEED: float = 200


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
	
	move_and_collide(movement.normalized() * MOVE_SPEED * delta)
