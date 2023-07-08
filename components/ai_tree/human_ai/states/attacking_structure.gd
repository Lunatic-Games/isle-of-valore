extends AIState


var attack_target: Den = null
var attack_timer: Timer = null


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("harvesting_wood")
	
	attack_target = human.target as Den
	human.sprite.flip_h = attack_target.global_position.x > human.global_position.x
	
	if attack_timer == null:
		attack_timer = Timer.new()
		attack_timer.wait_time = human.TIME_TO_ATTACK
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
	var human: Human = unit as Human
	attack_target.damage(1)
	
	if attack_target.health == 0 or attack_target.is_queued_for_deletion():
		ai_tree.transition_to("idle")
