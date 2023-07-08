class_name InteractComponent
extends Area2D

var cost_to_infuse: int = 10
var infused: bool = false


func interact() -> void:
	if GlobalGameState.HUD.currency >= cost_to_infuse && !infused && GlobalGameState.infuse_controller.can_infuse:
		infused = true
		get_parent().infuse() # Infuse the tree
		GlobalGameState.HUD.update_currency(-cost_to_infuse)
		GlobalGameState.infuse_controller.start_cooldown()

func show_interactive() -> void:
	if !infused:
		get_parent().show_interactive()

func hide_interactive() -> void:
	if !infused:
		get_parent().hide_interactive()
