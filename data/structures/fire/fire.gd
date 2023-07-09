class_name FireStructure
extends Structure

const meat_heal: int = 5


func eat_food(missing_health: int) -> int:
	var meat_to_eat: int = ceili(float(missing_health) / float(meat_heal))
	meat_to_eat = min(meat_to_eat, GlobalGameState.game.island.hq.held_food)
	GlobalGameState.game.island.hq.store_food(-meat_to_eat)
	return meat_heal * meat_to_eat
