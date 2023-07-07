class_name Structure
extends StaticBody2D

const INFUSE_TIMER: float = 3.0
const CURRENCY_GENERATED: int = 5

func interact() -> void:
	pass

func infuse():
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)

func infuse_trigger() -> void:
	GlobalGameState.HUD.update_currency(CURRENCY_GENERATED)
	get_tree().create_timer(INFUSE_TIMER).connect("timeout", infuse_trigger)
