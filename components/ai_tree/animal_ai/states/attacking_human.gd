extends AIState


var attack_timer: Timer = null


func on_enter(_previous_state: AIState = null):
	if attack_timer == null:
		attack_timer = Timer.new()
		attack_timer.wait_time = unit.time_to_attack
		attack_timer.timeout.connect(_on_attack_timer_timeout)
		add_child(attack_timer)
	
	attack_timer.start()


func update():
	if is_instance_valid(unit.target) == false:
		ai_tree.transition_to("idle")


func on_exit(_next_state: AIState = null):
	if attack_timer:
		attack_timer.stop()


func _on_attack_timer_timeout():
	unit.target.damage(1)
	
	if unit.target.health == 0 or unit.target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
	elif ai_tree.is_target_reached() == false:
		ai_tree.transition_to("going_to_attack_human")
	else:
		ai_tree.target_position = unit.target_access_point.global_position

