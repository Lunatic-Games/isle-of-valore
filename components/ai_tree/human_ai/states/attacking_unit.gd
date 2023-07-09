extends AIState


var attack_target: Animal = null
var attack_timer: Timer = null


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("harvesting_wood")
	
	attack_target = human.target as Animal
	human.sprite.flip_h = attack_target.global_position.x > human.global_position.x
	
	if attack_timer == null:
		attack_timer = Timer.new()
		attack_timer.wait_time = human.time_to_attack
		attack_timer.timeout.connect(_on_attack_timer_timeout)
		add_child(attack_timer)
	
	attack_timer.start()


func update():
	if is_instance_valid(attack_target) == false:
		ai_tree.transition_to("idle")


func on_exit(_next_state: AIState = null):
	if attack_timer:
		attack_timer.stop()


func _on_attack_timer_timeout():
	var human: Human = unit as Human
	if attack_target.health <= human.attack_damage and attack_target is Animal:
		human.amount_food_held += attack_target.meat_on_death
	attack_target.damage(human.attack_damage)
	
	if attack_target.health == 0 or attack_target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
	elif ai_tree.is_target_reached() == false:
		ai_tree.transition_to("going_to_attack_unit")
	else:
		ai_tree.target_position = unit.target_access_point.global_position
