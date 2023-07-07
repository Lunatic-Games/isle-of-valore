class_name InteractComponent
extends Area2D

var cost_to_infuse: int = 10
var infused: bool = false

func interact() -> void:
	if GlobalGameState.HUD.currency >= cost_to_infuse && !infused:
		infused = true
		get_parent().infuse() # Infuse the tree
		GlobalGameState.HUD.update_currency(-cost_to_infuse)
	
