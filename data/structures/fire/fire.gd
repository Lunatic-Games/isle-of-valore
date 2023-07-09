class_name FireStructure
extends Structure

const meat_heal = 5

func eat_food(missing_health, human):
	var meat_to_eat = ceil(missing_health / meat_heal)
	human.heal(meat_heal * meat_to_eat)
	GlobalGameState.game.island.hq.store_food(-meat_to_eat)
