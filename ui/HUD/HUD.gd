class_name HUD
extends CanvasLayer

var currency = 30
var current_ability = 0

func _ready() -> void:
	GlobalGameState.HUD = self

func update_currency(amount):
	currency += amount
	$CurrencyContainer/CurrencyLeft.text = str(currency)

func cycle_ability(change) -> void:
	var color_rect: ColorRect = $AbilityContainer.get_children()[current_ability]
	color_rect.color.v = 0
	$AbilityContainer.get_children()[current_ability].get_child(2).play("deselect")
	
	current_ability += change
	if current_ability < 0:
		current_ability = 0
	if current_ability > $AbilityContainer.get_child_count() -1:
		current_ability = $AbilityContainer.get_child_count() -1
	
	color_rect = $AbilityContainer.get_children()[current_ability]
	color_rect.color.v = 100
	$AbilityContainer.get_children()[current_ability].get_child(2).play("select")
	

func get_current_ability_index() -> int:
	return current_ability
