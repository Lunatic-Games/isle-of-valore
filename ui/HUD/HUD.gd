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
	current_ability += change
	if current_ability < 0:
		current_ability = 0
	if current_ability > $AbilityContainer.get_child_count() -1:
		current_ability = $AbilityContainer.get_child_count() -1
	
	$AbilityContainer.get_children()[current_ability]
