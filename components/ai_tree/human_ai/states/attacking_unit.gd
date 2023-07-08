extends AIState


func on_enter(_previous_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("harvesting_wood")


func on_exit(_next_state: AIState = null):
	var human: Human = unit as Human
	human.animation_player.play("idle")
