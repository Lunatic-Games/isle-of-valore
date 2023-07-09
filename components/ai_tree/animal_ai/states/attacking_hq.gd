extends AIState


var attack_target: HQStructure = null
var attack_timer: Timer = null


func on_enter(_previous_state: AIState = null):
	attack_target = unit.target as HQStructure
	unit.sprite.flip_h = unit.target.global_position.x > unit.global_position.x
	unit.animation_player.play("attacking")
	
	if attack_timer == null:
		attack_timer = Timer.new()
		attack_timer.wait_time = unit.time_to_attack
		attack_timer.timeout.connect(_on_attack_timer_timeout)
		add_child(attack_timer)
	
	attack_timer.start()


func update():
	if attack_target == null or attack_target.is_queued_for_deletion():
		ai_tree.transition_to("idle")


func on_exit(_next_state: AIState = null):
	if attack_timer:
		attack_timer.stop()


func _on_attack_timer_timeout():
	attack_target.damage(1)
	
	if attack_target.health == 0 or attack_target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
