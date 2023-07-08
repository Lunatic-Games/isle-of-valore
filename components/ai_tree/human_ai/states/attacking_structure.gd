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


func on_exit(_next_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("idle")


func _on_attack_timer_timeout():
	pass
