extends AIState


func on_enter(_previous_state: AIState = null):
	var fire = GlobalGameState.game.island.campfire
	var human: Human = unit as Human
	human.animation_player.play("walk")
	human.target_structure(fire)
	ai_tree.target_position = unit.target_access_point.global_position


func update():
	var human: Human = unit as Human
	if ai_tree.is_target_reached():
		GlobalGameState.game.island.hq.eat_food(human.max_health - human.health, human)
		ai_tree.transition_to("idle")
